import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tebak_kata/domain/models/word_fact.dart';
import 'package:tebak_kata/domain/repository/wordle_repository.dart';

enum CharacterStatus { exist, existDifferentIndex, notExist }

class CharacterModels {
  final String? character;

  final CharacterStatus? status;

  const CharacterModels({this.character, this.status});

  CharacterModels copyWith({String? character, CharacterStatus? status}) =>
      CharacterModels(
          character: character ?? this.character,
          status: status ?? this.status);
}

enum WordleStatus { initial, loading, success, error }

class WordleProvider with ChangeNotifier {
  final WordleRepository wordleRepo;

  final Random _random = Random();

  //total row that user tried to guess
  final int _tried = 5;

  //internal data
  String _word = "";
  Map<String, dynamic> _wordOccurences = {};
  List<String> _wordsData = [];
  final List<String> _tempWords = [];

  //status for fetching the data (random word)
  WordleStatus _status = WordleStatus.initial;
  WordleStatus get status => _status;

  List<List<CharacterModels>> _guessedWord = [];
  List<List<CharacterModels>> get guessedWord => _guessedWord;

  //To check if row of guessed word is filled
  bool _isValid = false;
  bool get isValid => _isValid;

  int _row = 0;
  int _column = 0;

  //limitation of hint
  int _hintMax = 2;
  int get hintMax => _hintMax;

  bool _isStageCompleted = false;
  bool get isStageCompleted => _isStageCompleted;

  List<WordFact> _wordFact = [];
  List<WordFact> get wordFact => _wordFact;

  bool _isWordsAvailable = true;
  bool get isWordAvailable => _isWordsAvailable;

  int _forceBuild = 0;
  int get forceBuild => _forceBuild;

  List<String> _hintWord = [];
  List<String> get hintWord => _hintWord;

  WordleProvider({required this.wordleRepo}) {
    getWord();
  }

  Future<void> getWord() async {
    try {
      final data = await wordleRepo.getRandomWord();

      // const data = "pose";
      _wordsData = data.map((e) => e.toUpperCase()).toList();

      _word = "BEST";

      for (int i = 0; i < _word.length; i++) {
        _hintWord.add(' ');
        _tempWords.add(_word[i]);
      }

      for (int i = 0; i < _tried; i++) {
        _guessedWord.add([]);
        for (int j = 0; j < _word.length; j++) {
          _guessedWord[i]
              .add(const CharacterModels(status: CharacterStatus.notExist));
        }
      }
      _wordOccurences = countWordOccurences(_word);

      _status = WordleStatus.success;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      _status = WordleStatus.error;
      notifyListeners();
    }
  }

  void onWordChanged(String value) {
    _isWordsAvailable = true;
    int length = _guessedWord[_row].length - 1;

    if (_guessedWord[_row][length].character != null && _isValid) {
      return;
    }

    _guessedWord = List.generate(
      _guessedWord.length,
      (row) {
        return List.generate(
          _guessedWord[row].length,
          (column) {
            if (row == _row && column == _column) {
              return _guessedWord[row][column].copyWith(character: value);
            } else {
              return _guessedWord[row][column];
            }
          },
        );
      },
    );

    _column++;

    if (_column == _word.length) {
      _isValid = true;
      notifyListeners();
      return;
    }

    notifyListeners();
  }

  Future<void> onSubmitButton() async {
    final String concattedCharacter =
        _guessedWord[_row].map((e) => e.character).join('');
    debugPrint(concattedCharacter);

    final bool newValue = _wordsData.contains(concattedCharacter);
    _isWordsAvailable = newValue;

    if (!_isWordsAvailable) {
      _forceBuild++;
      notifyListeners();
      return;
    }

    _guessedWord = changeCharacterStatus(_guessedWord, _row, _wordOccurences);

    _isStageCompleted = isComplete(_guessedWord[_row], _word, _tried, _row);

    /* _isValid depends on _isStageCompleted, if stage is not completed yet, isValid should be false*/
    _isValid = _isStageCompleted;

    /* need to refresh _wordOccurences value for next submit */
    _wordOccurences.clear();
    _wordOccurences = countWordOccurences(_word);

    _row++;
    _column = 0;

    notifyListeners();

    //after state updated and the stage completed, function will fetch word facts
    if (_isStageCompleted) {
      _hintMax = 0;
      _hintWord = _word.split('');
      notifyListeners();
      await getWordFacts();
    }
  }

  void onDeleteCharacter() {
    _isWordsAvailable = true;
    if (_column <= 0) {
      return;
    }
    _column--;
    _guessedWord = List.generate(
      _guessedWord.length,
      (row) {
        return List.generate(
          _guessedWord[row].length,
          (column) {
            if (row == _row && column == _column) {
              return _guessedWord[row][column].copyWith(character: '');
            } else {
              return _guessedWord[row][column];
            }
          },
        );
      },
    );

    _isValid = false;

    notifyListeners();
  }

  void onHintTextTap() {
    final generate = _random.nextInt(_tempWords.length);

    _hintWord = List.generate(_hintWord.length,
        (i) => i == generate ? _word[generate] : _hintWord[i]);
    _hintWord[generate] = _tempWords[generate];

    _tempWords.remove(_word[generate]);

    _hintMax--;

    notifyListeners();
  }

  Future<void> getWordFacts() async {
    _status = WordleStatus.loading;
    notifyListeners();

    try {
      final data = await wordleRepo.getWordFact(_word);
      _wordFact = data;
      _status = WordleStatus.success;
      notifyListeners();
    } catch (e) {
      _status = WordleStatus.success;
      notifyListeners();
    }
  }

  /* Helper method
    Check if the character exist same as word length */
  bool isComplete(
      List<CharacterModels> words, String word, int tried, int row) {
    return words.fold<int>(
                0,
                (prev, element) => element.status == CharacterStatus.exist
                    ? prev + 1
                    : prev + 0) ==
            word.length ||
        row == _tried - 1;
  }

  Map<String, dynamic> countWordOccurences(String word) {
    var wordOccurences = <String, dynamic>{};
    for (int i = 0; i < word.length; i++) {
      if (wordOccurences.containsKey(word[i])) {
        wordOccurences[word[i]] = wordOccurences[word[i]] + 1;
      } else {
        wordOccurences[word[i]] = 1;
      }
    }
    return wordOccurences;
  }

  List<List<CharacterModels>> changeCharacterStatus(
      List<List<CharacterModels>> guessedWord,
      int row,
      Map<String, dynamic> wordOccurences) {
    final temp = List.generate(
      guessedWord.length,
      (r) => List.generate(
        guessedWord[r].length,
        (c) => guessedWord[r][c],
      ),
    );

    for (int i = 0; i < _word.length; i++) {
      if (_word[i] == temp[row][i].character &&
          wordOccurences[temp[row][i].character] != 0) {
        temp[row][i] = temp[row][i].copyWith(status: CharacterStatus.exist);
        wordOccurences[temp[row][i].character!] =
            wordOccurences[temp[row][i].character!] - 1;
      } else if (_word.contains(temp[row][i].character!) &&
          _word[i] != temp[row][i].character &&
          wordOccurences[temp[row][i].character] != 0) {
        temp[row][i] =
            temp[row][i].copyWith(status: CharacterStatus.existDifferentIndex);
        wordOccurences[temp[row][i].character!] =
            wordOccurences[temp[row][i].character!] - 1;
      } else {
        temp[row][i] = temp[row][i].copyWith(status: CharacterStatus.notExist);
      }
    }
    return temp;
  }
}


  // Map<String, Map<String, dynamic>> countWordOccurences(String word) {
  //   var wordOccurences = <String, Map<String, dynamic>>{};
  //   for (int i = 0; i < word.length; i++) {
  //     if (wordOccurences.containsKey(word[i])) {
  //       wordOccurences[word[i]]?["count"] =
  //           wordOccurences[word[i]]?["count"] + 1;
  //       wordOccurences[word[i]]
  //           ?["list"] = List.from(wordOccurences[word[i]]?["list"])..add(i);
  //     } else {
  //       wordOccurences[word[i]] = {};
  //       wordOccurences[word[i]]?["count"] = 1;
  //       wordOccurences[word[i]]?["list"] = [i];
  //     }
  //   }

  //   return wordOccurences;
  // }
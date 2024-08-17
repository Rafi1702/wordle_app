import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tebak_kata/domain/wordle/character_models.dart';

enum StageStatus { initial, complete }

class WordleProvider with ChangeNotifier {
  final Random _random = Random();
  final int _tried = 6;

  int get tried => _tried;
  final String _word = "COME";

  Map<String, dynamic> _wordOccurences = {};

  StageStatus _stageStatus = StageStatus.initial;
  StageStatus get stageStatus => _stageStatus;

  final List<List<CharacterModels>> _guessedWord = [];
  List<List<CharacterModels>> get guessedWord => _guessedWord;

  //To check if row of guessed word is filled
  bool _isValid = false;
  bool get isValid => _isValid;

  int row = 0;
  int column = 0;

  WordleProvider() {
    initialGuessedWord();
  }

  Future<void> initialGuessedWord() async {
    for (int i = 0; i < _tried; i++) {
      _guessedWord.add([]);
      for (int j = 0; j < _word.length; j++) {
        _guessedWord[i]
            .add(const CharacterModels(status: CharacterStatus.notExist));
      }
    }

    _wordOccurences = countWordOccurences(_word);

    notifyListeners();
  }

  void onWordChanged(String value) {
    int length = _guessedWord[row].length - 1;

    if (_guessedWord[row][length].character != null) {
      return;
    }

    _guessedWord[row][column] =
        _guessedWord[row][column].copyWith(character: value);

    column += 1;

    if (column == _word.length) {
      _isValid = true;
      notifyListeners();
      return;
    }

    notifyListeners();
  }

  void onSubmitButton() {
    for (int i = 0; i < _word.length; i++) {
      if (_word[i] == _guessedWord[row][i].character &&
          _wordOccurences[_guessedWord[row][i].character] != 0) {
        _guessedWord[row][i] =
            _guessedWord[row][i].copyWith(status: CharacterStatus.exist);
        _wordOccurences[_guessedWord[row][i].character!] =
            _wordOccurences[_guessedWord[row][i].character!] - 1;
      } else if (_word.contains(_guessedWord[row][i].character!) &&
          _word[i] != _guessedWord[row][i].character &&
          _wordOccurences[_guessedWord[row][i].character] != 0) {
        _guessedWord[row][i] = _guessedWord[row][i]
            .copyWith(status: CharacterStatus.existDifferentIndex);
        _wordOccurences[_guessedWord[row][i].character!] =
            _wordOccurences[_guessedWord[row][i].character!] - 1;
      } else {
        _guessedWord[row][i] =
            _guessedWord[row][i].copyWith(status: CharacterStatus.notExist);
      }
    }

    _wordOccurences = countWordOccurences(_word);

    if (isStageCompleted(_guessedWord[row], _word) || row == _tried - 1) {
      _stageStatus = StageStatus.complete;
    } else {
      _isValid = false;
    }

    // if (_guessedWord[row][column].character != null) {
    //   column += 1;
    //   return;
    // }
    row++;
    column = 0;

    notifyListeners();
  }

  void onDeleteCharacter() {
    if (column <= 0) {
      return;
    }
    _guessedWord[row][--column] =
        const CharacterModels(character: null, status: null);
    _isValid = false;

    notifyListeners();
  }

  void onHintTextTap() {
    final generate = _random.nextInt(_word.length);

    _guessedWord[_tried - 1][generate] = CharacterModels(
        character: _word[generate], status: CharacterStatus.exist);

    notifyListeners();
  }

  /* Helper method
    Check if the character exist same as word length */
  bool isStageCompleted(List<CharacterModels> words, String word) {
    int existCounter = 0;
    for (int i = 0; i < words.length; i++) {
      if (words[i].status == CharacterStatus.exist) {
        existCounter++;
      }
    }

    return existCounter == word.length;
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
import 'package:flutter/material.dart';

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

enum StageStatus { initial, complete }

class WordleProvider with ChangeNotifier {
  final _try = 6;
  final String _word = "come";
  final Map<String, dynamic> _wordOccurences = {};
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

  void initialGuessedWord() {
    for (int i = 0; i < _try; i++) {
      _guessedWord.add([]);
      for (int j = 0; j < _word.length; j++) {
        _guessedWord[i]
            .add(const CharacterModels(status: CharacterStatus.notExist));
      }
    }

    for (int i = 0; i < _word.length; i++) {
      if (_wordOccurences.containsKey(_word[i])) {
        _wordOccurences[_word[i]] = _wordOccurences[_word[i]] + 1;
      } else {
        _wordOccurences[_word[i]] = 1;
      }
    }

    notifyListeners();
  }

  void onWordChanged(String value) {
    if (column == _word.length) {
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
      if (_word[i] == _guessedWord[row][i].character) {
        _guessedWord[row][i] =
            _guessedWord[row][i].copyWith(status: CharacterStatus.exist);
      } else if (_word.contains(_guessedWord[row][i].character!) &&
          _word[i] != _guessedWord[row][i].character) {
        _guessedWord[row][i] = _guessedWord[row][i]
            .copyWith(status: CharacterStatus.existDifferentIndex);
      } else {
        _guessedWord[row][i] =
            _guessedWord[row][i].copyWith(status: CharacterStatus.notExist);
      }
    }

    if (isStageCompleted(_guessedWord[row], _word) || row == _try - 1) {
      _stageStatus = StageStatus.complete;
    } else {
      _isValid = false;
    }

    row++;
    column = 0;

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
}

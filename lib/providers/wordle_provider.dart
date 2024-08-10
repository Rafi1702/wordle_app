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

enum StageStatus { notComplete, complete }

class WordleProvider with ChangeNotifier {
  final _try = 6;
  String word = "come";

  String _valueHolder = "";

  String get valueHolder => _valueHolder;

  StageStatus _stageStatus = StageStatus.notComplete;

  StageStatus get stageStatus => _stageStatus;

  final List<List<CharacterModels>> _guessedWord = [];

  List<List<CharacterModels>> get guessedWord => _guessedWord;

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
      for (int j = 0; j < word.length; j++) {
        _guessedWord[i]
            .add(const CharacterModels(status: CharacterStatus.notExist));
      }
    }

    notifyListeners();
  }

  void onWordChanged(String value) {
    if (column == word.length) {
      return;
    }
    _guessedWord[row][column] =
        _guessedWord[row][column].copyWith(character: value);

    column += 1;

    if (column == word.length) {
      _isValid = true;
      notifyListeners();
      return;
    }

    notifyListeners();
  }

  void onSubmitButton() {
    for (int i = 0; i < word.length; i++) {
      if (word[i] == _guessedWord[row][i].character) {
        _guessedWord[row][i] =
            _guessedWord[row][i].copyWith(status: CharacterStatus.exist);
      } else if (word.contains(_guessedWord[row][i].character!) &&
          word[i] != _guessedWord[row][i].character) {
        _guessedWord[row][i] = _guessedWord[row][i]
            .copyWith(status: CharacterStatus.existDifferentIndex);
      } else {
        _guessedWord[row][i] =
            _guessedWord[row][i].copyWith(status: CharacterStatus.notExist);
      }
    }

    if (isStageCompleted(_guessedWord[row], word) || row == _try - 1) {
      _stageStatus = StageStatus.complete;
      _isValid = true;
    } else {
      _isValid = false;
    }

    row++;
    column = 0;

    notifyListeners();
  }

  //helper method
  bool isStageCompleted(List<CharacterModels> words, String word) {
    int existCounter = 0;
    for (int i = 0; i < words.length; i++) {
      if (words[i].status == CharacterStatus.exist) {
        existCounter++;
      }
    }

    print(existCounter);

    return existCounter == word.length;
  }
}

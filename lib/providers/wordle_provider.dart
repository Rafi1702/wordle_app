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

class WordleProvider with ChangeNotifier {
  String word = "come";

  String _valueHolder = "";

  final List<List<CharacterModels>> _guessedWord = [];

  List<List<CharacterModels>> get guessedWord => _guessedWord;

  bool _isValid = false;

  bool get isValid => _isValid;

  int index = 0;

  WordleProvider() {
    initialGuessedWord();
  }

  void onWordChanged(String value) {
    if (value.isEmpty) {
      _valueHolder = _valueHolder.substring(0, _valueHolder.length - 1);
      return;
    }
    _valueHolder += value;

    if (_valueHolder.length == word.length) {
      _isValid = true;
    }

    notifyListeners();
  }

  void initialGuessedWord() {
    for (int i = 0; i < word.length; i++) {
      _guessedWord.add([]);
    }
    notifyListeners();
  }

  void onSubmitButton() {
    for (int i = 0; i < _valueHolder.length; i++) {
      _guessedWord[index][i] =
          _guessedWord[index][i].copyWith(character: _valueHolder[i]);
    }

    for (int i = 0; i < word.length; i++) {
      if (word[i] == _guessedWord[index][i].character) {
        _guessedWord[index][i] =
            _guessedWord[index][i].copyWith(status: CharacterStatus.exist);
      } else if (word.contains(_guessedWord[index][i].character!) &&
          word[i] != _guessedWord[index][i].character) {
        _guessedWord[index][i] = _guessedWord[index][i]
            .copyWith(status: CharacterStatus.existDifferentIndex);
      } else {
        _guessedWord[index][i] =
            _guessedWord[index][i].copyWith(status: CharacterStatus.notExist);
      }
    }

    _valueHolder = "";
    index++;

    notifyListeners();
  }
}

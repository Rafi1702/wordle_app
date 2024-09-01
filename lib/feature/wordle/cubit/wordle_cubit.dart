import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebak_kata/domain/models/word_fact.dart';
import 'package:tebak_kata/domain/repository/wordle_repository.dart';

part 'wordle_state.dart';

class WordleCubit extends Cubit<WordleState> {
  /* private state */
  final Random _random = Random();
  int _column = 0;
  int _row = 0;
  final int _tried = 5;
  Map<String, dynamic> _wordOccurences = {};
  final List<int> _tempWords = [];
  List<String> _wordsData = [];
  String _word = '';

  WordleCubit({required this.wordleRepository}) : super(const WordleState());
  final WordleRepository wordleRepository;
  Future<void> getWord() async {
    try {
      List<String> updatedHintWord = [];
      List<List<CharacterModels>> updatedGuessedWord = [];
      final data = await wordleRepository.getRandomWord();

      _wordsData = List.from(data.map((e) => e.toUpperCase()).toList());

      _word = _wordsData[_random.nextInt(_wordsData.length)];
      debugPrint(_word);
      for (int i = 0; i < _word.length; i++) {
        updatedHintWord.add(' ');
        _tempWords.add(i);
      }

      for (int i = 0; i < _tried; i++) {
        updatedGuessedWord.add([]);
        for (int j = 0; j < _word.length; j++) {
          updatedGuessedWord[i]
              .add(const CharacterModels(status: CharacterStatus.notExist));
        }
      }
      _wordOccurences = countWordOccurences(_word);

      emit(
        state.copyWith(
          guessedWord: updatedGuessedWord,
          hintWord: updatedHintWord,
          randomWordStatus: WordlePageStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          randomWordError: e.toString(),
          randomWordStatus: WordlePageStatus.error,
        ),
      );
    }
  }

  Future<void> getWordFacts() async {
    emit(state.copyWith(wordFactStatus: WordlePageStatus.loading));

    try {
      final data = await wordleRepository.getWordFact(_word);

      emit(state.copyWith(
          wordFact: data, wordFactStatus: WordlePageStatus.success));
    } catch (e) {
      emit(state.copyWith(
          wordFactStatus: WordlePageStatus.error, wordFactError: e.toString()));
    }
  }

  void onWordChanged(String character) {
    emit(state.copyWith(isWordAvailable: true));

    int length = state.guessedWord[_row].length - 1;

    if (state.guessedWord[_row][length].character != null && state.isValid) {
      return;
    }
    final updatedGuessedWord = List.generate(
      state.guessedWord.length,
      (row) {
        return List.generate(
          state.guessedWord[row].length,
          (column) {
            if (row == _row && column == _column) {
              return state.guessedWord[row][column]
                  .copyWith(character: character);
            } else {
              return state.guessedWord[row][column];
            }
          },
        );
      },
    );
    _column++;

    if (_column == _word.length) {
      return emit(
          state.copyWith(isValid: true, guessedWord: updatedGuessedWord));
    }

    emit(
      state.copyWith(
        guessedWord: updatedGuessedWord,
      ),
    );
  }

  Future<void> onSubmitButton() async {
    final String concattedCharacter =
        state.guessedWord[_row].map((e) => e.character).join('');

    final updatedIsWordsAvailable = _wordsData.contains(concattedCharacter);

    emit(state.copyWith(isWordAvailable: updatedIsWordsAvailable));
    //Stop when _isWordsAvailable false, it wont go to next row
    if (!state.isWordAvailable) {
      return;
    }

    final updatedGuessedWord =
        changeCharacterStatus(state.guessedWord, _row, _wordOccurences);

    final updatedIsStageCompleted =
        isComplete(updatedGuessedWord[_row], _word, _tried, _row);

    /* _isValid depends on _isStageCompleted, if stage is not completed yet, isValid should be false*/
    final updatedIsValid = updatedIsStageCompleted;

    /* need to refresh _wordOccurences value for next submit */
    _wordOccurences = countWordOccurences(_word);

    _row++;
    _column = 0;

    emit(
      state.copyWith(
          isStageCompleted: updatedIsStageCompleted,
          isWordAvailable: updatedIsWordsAvailable,
          guessedWord: updatedGuessedWord,
          isValid: updatedIsValid),
    );
  }

  void onDeleteCharacter() {
    emit(state.copyWith(isWordAvailable: true));
    final updatedGuessedWord = List.generate(
      state.guessedWord.length,
      (row) {
        return List.generate(
          state.guessedWord[row].length,
          (column) {
            if (row == _row && column == _column) {
              return state.guessedWord[row][column].copyWith(character: '');
            } else {
              return state.guessedWord[row][column];
            }
          },
        );
      },
    );
    if (_column <= 0) {
      _column = 0;

      return emit(state.copyWith(guessedWord: updatedGuessedWord));
    }

    _column--;

    emit(state.copyWith(
      guessedWord: updatedGuessedWord,
      isValid: false,
    ));
  }

  void onHintButton() async {
    if (state.hintLimit <= 0) {
      emit(state.copyWith(hintLimit: -1));
      return;
    }
    final generateRandomIndex = _tempWords[_random.nextInt(_tempWords.length)];

    final updatedHintWord = List.generate(
        state.hintWord.length,
        (i) => i == generateRandomIndex
            ? _word[generateRandomIndex]
            : state.hintWord[i]);

    _tempWords.remove(generateRandomIndex);

    final updatedHintLimit = state.hintLimit - 1;
    debugPrint(updatedHintLimit.toString());

    emit(
        state.copyWith(hintWord: updatedHintWord, hintLimit: updatedHintLimit));
  }

  void onGiveUpButton() async {
    final updatedHint = _word.split('');
    emit(
      state.copyWith(
        isStageCompleted: true,
        hintWord: updatedHint,
      ),
    );
  }

  /* Helper Function*/
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
        continue;
      }
    }

    for (int i = 0; i < _word.length; i++) {
      if (_word.contains(temp[row][i].character!) &&
          _word[i] != temp[row][i].character &&
          wordOccurences[temp[row][i].character] != 0) {
        temp[row][i] =
            temp[row][i].copyWith(status: CharacterStatus.existDifferentIndex);
        wordOccurences[temp[row][i].character!] =
            wordOccurences[temp[row][i].character!] - 1;
      }
    }

    return temp;
  }
}

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

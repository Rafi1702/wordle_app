part of 'wordle_cubit.dart';

enum WordlePageStatus { initial, loading, success, error }

class WordleState extends Equatable {
  const WordleState({
    this.wordFactStatus = WordlePageStatus.initial,
    this.randomWordStatus = WordlePageStatus.initial,
    this.isValid = false,
    this.isStageCompleted = false,
    this.isWordAvailable = true,
    this.hintLimit = 2,
    this.guessedWord = const [],
    this.randomWordError = '',
    this.hintWord = const [],
    this.wordFactError = '',
    this.wordFact = const [],
  });

  WordleState copyWith({
    WordlePageStatus? wordFactStatus,
    WordlePageStatus? randomWordStatus,
    bool? isValid,
    bool? isStageCompleted,
    bool? isWordAvailable,
    int? hintLimit,
    List<List<CharacterModels>>? guessedWord,
    String? randomWordError,
    List<String>? hintWord,
    String? wordFactError,
    List<WordFact>? wordFact,
    bool? isHintAvailable,
  }) =>
      WordleState(
        wordFactStatus: wordFactStatus ?? this.wordFactStatus,
        randomWordStatus: randomWordStatus ?? this.randomWordStatus,
        isValid: isValid ?? this.isValid,
        isStageCompleted: isStageCompleted ?? this.isStageCompleted,
        isWordAvailable: isWordAvailable ?? this.isWordAvailable,
        hintLimit: hintLimit ?? this.hintLimit,
        guessedWord: guessedWord ?? this.guessedWord,
        randomWordError: randomWordError ?? this.randomWordError,
        hintWord: hintWord ?? this.hintWord,
        wordFactError: wordFactError ?? this.wordFactError,
        wordFact: wordFact ?? this.wordFact,
      );

  final WordlePageStatus wordFactStatus;
  final WordlePageStatus randomWordStatus;
  final List<List<CharacterModels>> guessedWord;
  final bool isValid;
  final int hintLimit;
  final bool isStageCompleted;
  final bool isWordAvailable;
  final List<String> hintWord;
  final String randomWordError;
  final String wordFactError;
  final List<WordFact> wordFact;

  @override
  List<Object> get props => [
        hintLimit,
        wordFactStatus,
        randomWordStatus,
        guessedWord,
        isValid,
        isStageCompleted,
        isWordAvailable,
        hintWord,
        randomWordError,
        wordFactError,
        wordFact,
      ];
}

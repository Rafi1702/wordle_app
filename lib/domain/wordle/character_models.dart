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

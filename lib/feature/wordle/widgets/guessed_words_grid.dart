import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/feature/wordle/providers/wordle_provider.dart';

class GuessedWordsGrid extends StatelessWidget {
  const GuessedWordsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final guessedWord = context
        .select<WordleProvider, List<List<CharacterModels>>>((wordleProvider) => wordleProvider.guessedWord);
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: guessedWord.length,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10.0,
          );
        },
        itemBuilder: (context, triedIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  List<Widget>.generate(guessedWord[triedIndex].length, (j) {
                return SizedBox(
                  height: 60.0,
                  width: 60.0,
                  child: Card(
                    color:
                        colorHelper(guessedWord[triedIndex][j].status, context),
                    child: Center(
                      child: Text(
                        guessedWord[triedIndex][j].character ?? '',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }
}

Color? colorHelper(CharacterStatus? status, BuildContext context) {
  switch (status) {
    case CharacterStatus.exist:
      return Colors.green;
    case CharacterStatus.existDifferentIndex:
      return const Color(0xFFFFD700);
    default:
      return null;
  }
}

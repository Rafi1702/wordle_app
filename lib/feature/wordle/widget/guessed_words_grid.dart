import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tebak_kata/feature/wordle/cubit/wordle_cubit.dart';
import 'package:tebak_kata/feature/wordle/widget/letter_card.dart';

class GuessedWordsGrid extends StatelessWidget {
  const GuessedWordsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordleCubit, WordleState, List<List<CharacterModels>>>(
      selector: (state) {
        return state.guessedWord;
      },
      builder: (context, state) {
        return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.length,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10.0,
              );
            },
            itemBuilder: (context, triedIndex) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(state[triedIndex].length, (j) {
                  return LetterCard(
                    letter: state[triedIndex][j].character ?? '',
                    color: colorHelper(
                      state[triedIndex][j].status,
                    ),
                  );
                }),
              );
            });
      },
    );
  }
}

Color? colorHelper(CharacterStatus? status) {
  switch (status) {
    case CharacterStatus.exist:
      return Colors.green;
    case CharacterStatus.existDifferentIndex:
      return const Color(0xFFFFD700);
    default:
      return null;
  }
}

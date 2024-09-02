import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tebak_kata/feature/wordle/cubit/wordle_cubit.dart';

import 'package:tebak_kata/feature/wordle/presentation/fact_words_page.dart';
import 'package:tebak_kata/feature/wordle/widget/keyboard.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final basetextStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Theme.of(context).colorScheme.onPrimary);
    final titleTextStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Theme.of(context).colorScheme.onPrimary);
    final iconColor = Theme.of(context).colorScheme.onPrimary;
    return BlocBuilder<WordleCubit, WordleState>(
      buildWhen: (previous, current) =>
          previous.wordFactStatus != current.wordFactStatus ||
          previous.wordFact != current.wordFact ||
          previous.wordFactError != current.wordFactError ||
          previous.isStageCompleted != current.isStageCompleted,
      builder: (context, state) {
        if (state.isStageCompleted && state.wordFact.isNotEmpty) {
          final phonetics = state.wordFact.first.phonetics;
          switch (state.wordFactStatus) {
            case WordlePageStatus.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case WordlePageStatus.success:
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(FactWordsPage.route,
                      arguments: state.wordFact);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Theme.of(context).colorScheme.onSurface),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              phonetics.isNotEmpty
                                  ? phonetics[0].text ?? ''
                                  : 'Unavailable',
                              style: titleTextStyle),
                          IconButton(
                            icon: Icon(
                              Icons.volume_up,
                              color: iconColor,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Text(state.wordFact.first.meanings.first.partOfSpeech,
                          style: basetextStyle),
                      Text(
                          state.wordFact.first.meanings.first.definitions.first
                              .definition,
                          style: basetextStyle),
                    ],
                  ),
                ),
              );
            case WordlePageStatus.error:
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh,
                          color: Colors.black, size: 40),
                      onPressed: () {
                        context.read<WordleCubit>().getWordFacts();
                      },
                    ),
                    Text(
                      state.wordFactError,
                      style: basetextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            default:
              return Container();
          }
        }
        return const KeyBoard();
      },
    );
  }
}

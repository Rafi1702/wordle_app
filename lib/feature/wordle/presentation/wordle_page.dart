import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tebak_kata/feature/settings/widgets/settings_dialog.dart';
import 'package:tebak_kata/feature/wordle/widgets/action_button_wordle.dart';
import 'package:tebak_kata/feature/wordle/widgets/hint_word_section.dart';

import 'package:tebak_kata/feature/wordle/widgets/keyboard.dart';

import 'package:tebak_kata/feature/wordle/widgets/word_fact_section.dart';

import 'package:tebak_kata/feature/wordle/providers/wordle_provider.dart';

class WordlePage extends StatelessWidget {
  static const route = '/';
  const WordlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Wordle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog<double>(
                context: context,
                builder: (BuildContext context) => const CustomDialog(),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<WordleProvider>(
          builder: (context, state, child) {
            switch (state.status) {
              case WordleStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WordleStatus.success || WordleStatus.loading:
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      HintWord(
                        hintWord: state.hintWord,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.guessedWord.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10.0,
                            );
                          },
                          itemBuilder: (context, triedIndex) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: List<Widget>.generate(
                                    state.guessedWord[triedIndex].length, (j) {
                                  return SizedBox(
                                    height: 60.0,
                                    width: 60.0,
                                    child: Card(
                                      color: colorHelper(
                                          state.guessedWord[triedIndex][j]
                                              .status,
                                          context),
                                      child: Center(
                                        child: Text(
                                          state.guessedWord[triedIndex][j]
                                                  .character ??
                                              '',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          }),
                      ActionButtonsWordle(
                        hintMax: state.hintMax,
                        isStageCompleted: state.isStageCompleted,
                        isValid: state.isValid,
                        isWordContain: state.isWordContain,
                      ),
                      state.isStageCompleted
                          ? WordFactsSection(
                              wordFacts: state.wordFact,
                              isLoading: state.status == WordleStatus.loading,
                            )
                          : const KeyBoard(),
                    ],
                  ),
                );

              case WordleStatus.error:
                return const Center(
                  child: Text('Error'),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
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
}

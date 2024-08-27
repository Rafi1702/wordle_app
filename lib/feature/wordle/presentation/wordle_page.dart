import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tebak_kata/feature/settings/widgets/settings_dialog.dart';
import 'package:tebak_kata/feature/wordle/widgets/action_button_wordle.dart';
import 'package:tebak_kata/feature/wordle/widgets/guessed_words_grid.dart';
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
        child: Builder(builder: (context) {
          final status = context
              .select((WordleProvider wordleProvider) => wordleProvider.status);
          switch (status) {
            case WordleStatus.initial:
              return Center(
                child: Image.asset('assets/Blocks@1x-1.0s-200px-200px.gif'),
              );
            case WordleStatus.success || WordleStatus.loading:
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HintWordSection(),
                    GuessedWordsGrid(),
                    ActionButtonsWordle(),
                    BottomSection(),
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
        }),
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isStageCompleted = context.select(
        (WordleProvider wordleProvider) => wordleProvider.isStageCompleted);
    return isStageCompleted ? const WordFactsSection() : const KeyBoard();
  }
}

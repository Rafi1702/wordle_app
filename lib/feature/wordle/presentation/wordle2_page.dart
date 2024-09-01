import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tebak_kata/feature/settings/widgets/settings_dialog.dart';
import 'package:tebak_kata/feature/wordle/cubit/wordle_cubit.dart';
import 'package:tebak_kata/feature/wordle/widget2/action_button_wordle.dart';
import 'package:tebak_kata/feature/wordle/widget2/guessed_words_grid.dart';
import 'package:tebak_kata/feature/wordle/widget2/hint_word_section.dart';
import 'package:tebak_kata/feature/wordle/widget2/word_fact_section.dart';

class WordlePage2 extends StatelessWidget {
  static const route = '/wordle_page2';
  const WordlePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<WordleCubit, WordleState>(
          listenWhen: (prev, current) =>
              prev.isWordAvailable != current.isWordAvailable,
          listener: (context, state) {
            if (!state.isWordAvailable) {
              Fluttertoast.showToast(
                  msg: "Kata Tidak Ada",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Theme.of(context).colorScheme.onError,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
        ),
        BlocListener<WordleCubit, WordleState>(
          listenWhen: (prev, current) => prev.hintLimit != current.hintLimit,
          listener: (context, state) {
            if (state.hintLimit <= 0) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () {
                            context.read<WordleCubit>().onGiveUpButton();
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            }
          },
        ),
      ],
      child: Scaffold(
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
                  builder: (BuildContext context) => const SettingsDialog(),
                );
              },
            )
          ],
        ),
        body: SafeArea(
          child: BlocSelector<WordleCubit, WordleState, WordlePageStatus>(
            selector: (state) {
              return state.randomWordStatus;
            },
            builder: (context, state) {
              return Builder(builder: (context) {
                switch (state) {
                  case WordlePageStatus.initial:
                    return Center(
                      child:
                          Image.asset('assets/Blocks@1x-1.0s-200px-200px.gif'),
                    );
                  case WordlePageStatus.success || WordlePageStatus.loading:
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

                  default:
                    return Container();
                }
              });
            },
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:tebak_kata/feature/settings/widgets/settings_dialog.dart';
import 'package:tebak_kata/feature/wordle/widgets/action_button_wordle.dart';
import 'package:tebak_kata/feature/wordle/widgets/guessed_words_grid.dart';
import 'package:tebak_kata/feature/wordle/widgets/hint_word_section.dart';

import 'package:tebak_kata/feature/wordle/widgets/word_fact_section.dart';

import 'package:tebak_kata/feature/wordle/providers/wordle_provider.dart';

class WordlePage extends StatefulWidget {
  static const route = '/wordle_page';
  const WordlePage({super.key});

  @override
  State<WordlePage> createState() => _WordlePageState();
}

class _WordlePageState extends State<WordlePage> {
  late final WordleProvider wordleProvider;
  @override
  void initState() {
    wordleProvider = context.read<WordleProvider>();
    wordleProvider.addListener(wordleListeners);
    super.initState();
  }

  void wordleListeners() {
    if (!wordleProvider.isWordAvailable) {
      Fluttertoast.showToast(
          msg: "Kata Tidak Ada",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.onError,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void dispose() {
    wordleProvider.removeListener(wordleListeners);
    super.dispose();
  }

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
        child: Selector<WordleProvider, WordleStatus>(
          selector: (_, state) => state.wordStatus,
          shouldRebuild: (prev, current) => prev != current,
          builder: (context, status, __) => Builder(builder: (context) {
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

              default:
                return Container();
            }
          }),
        ),
      ),
    );
  }
}

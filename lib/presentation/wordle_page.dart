import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/helper/app_theme.dart';
import 'package:tebak_kata/helper/qwerty.dart';
import 'package:tebak_kata/providers/audio_provider.dart';
import 'package:tebak_kata/providers/wordle_provider.dart';

class WordlePage extends StatelessWidget {
  static const route = '/';
  const WordlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.0,
        title: const Text("Wordle"),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Consumer<WordleProvider>(
        builder: (context, state, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List<Widget>.generate(
              6,
              (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(4, (j) {
                      return Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: colorHelper(state.guessedWord[i][j].status),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child:
                                Text(state.guessedWord[i][j].character ?? '')),
                      );
                    }),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: state.isValid
                  ? () {
                      if (state.stageStatus == StageStatus.complete) {
                        Navigator.of(context).popAndPushNamed(WordlePage.route);
                      } else {
                        context.read<WordleProvider>().onSubmitButton();
                      }
                    }
                  : null,
              child: state.stageStatus == StageStatus.complete
                  ? const Text('Next')
                  : const Text('Submit'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10.0,
                spacing: 4.0,
                children: List.generate(QwertyKey.values.length, (index) {
                  final qwertyKey = QwertyKey.values[index];
                  return InkWell(
                    onTap: qwertyKey == QwertyKey.delete
                        ? null
                        : () {
                            context.read<AudioProvider>().playAudio();
                            context
                                .read<WordleProvider>()
                                .onWordChanged(QwertyKey.values[index].name);
                          },
                    child: Container(
                      decoration: BoxDecoration(
                        color: qwertyKey == QwertyKey.delete
                            ? Colors.red
                            : AppTheme.gridBoxColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      height: 43.0,
                      width: qwertyKey == QwertyKey.delete ? 50.0 : 40.0,
                      child: Center(
                        child: Text(QwertyKey.values[index].name),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color? colorHelper(CharacterStatus? status) {
    switch (status) {
      case CharacterStatus.exist:
        return Colors.green;
      case CharacterStatus.existDifferentIndex:
        return Colors.yellow;
      default:
        return AppTheme.gridBoxColor;
    }
  }
}

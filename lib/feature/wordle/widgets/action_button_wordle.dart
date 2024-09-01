import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tebak_kata/feature/wordle/presentation/wordle_page.dart';

import 'package:tebak_kata/feature/wordle/providers/wordle_provider.dart';

class ActionButtonsWordle extends StatelessWidget {
  const ActionButtonsWordle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final isStageCompleted = context.select(
          (WordleProvider wordleProvider) => wordleProvider.isStageCompleted);
      final wordFactStatus = context.select(
          (WordleProvider wordleProvider) => wordleProvider.wordFactStatus);
      final isValid = context
          .select((WordleProvider wordleProvider) => wordleProvider.isValid);
      final hintMax = context
          .select((WordleProvider wordleProvider) => wordleProvider.hintMax);
      print("build");
      return Row(
        children: [
          const Spacer(
            flex: 2,
          ),
          ElevatedButton(
              style: const ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(
                Size(
                  160,
                  30.0,
                ),
              )),
              onPressed: isValid && wordFactStatus != WordleStatus.loading
                  ? isStageCompleted
                      ? () => Navigator.of(context)
                          .pushReplacementNamed(WordlePage.route)
                      : () {
                          context.read<WordleProvider>().onSubmitButton();
                        }
                  : null,
              child: wordFactStatus == WordleStatus.loading
                  ? const SizedBox(
                      height: 20.0,
                      width: 20.0,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Text(isStageCompleted ? 'Next' : 'Submit')),
          const Spacer(),
          ElevatedButton(
            style: const ButtonStyle(
              shape: WidgetStatePropertyAll(
                CircleBorder(),
              ),
            ),
            onPressed: isStageCompleted
                ? null
                : () {
                    context.read<WordleProvider>().onHintButton();
                  },
            child: Icon(hintMax <= 0 ? Icons.flag : Icons.lightbulb_rounded,
                color: hintMax <= 0 ? Colors.white : Colors.yellow, size: 30.0),
          )
        ],
      );
    });
  }
}

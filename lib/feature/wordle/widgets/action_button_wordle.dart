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

      final isValid = context
          .select((WordleProvider wordleProvider) => wordleProvider.isValid);
      final hintMax = context
          .select((WordleProvider wordleProvider) => wordleProvider.hintMax);

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
              onPressed: isValid
                  ? isStageCompleted
                      ? () => Navigator.of(context).pushReplacementNamed(WordlePage.route)
                      : () {
                          context.read<WordleProvider>().onSubmitButton();
                        }
                  : null,
              child: Text(isStageCompleted ? 'Next' : 'Submit')),
          const Spacer(),
          ElevatedButton(
            style: const ButtonStyle(
              shape: WidgetStatePropertyAll(
                CircleBorder(),
              ),
            ),
            onPressed: hintMax == 0
                ? null
                : () {
                    context.read<WordleProvider>().onHintTextTap();
                  },
            child: Icon(Icons.lightbulb_rounded,
                color: hintMax == 0 ? null : Colors.yellow, size: 30.0),
          )
        ],
      );
    });
  }
}

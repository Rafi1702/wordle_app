import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/feature/wordle/presentation/wordle_page.dart';
import 'package:tebak_kata/feature/wordle/providers/wordle_provider.dart';

class ActionButtonsWordle extends StatelessWidget {
  final bool isStageCompleted;
  final bool isValid;
  final bool isWordContain;
  final int hintMax;
  const ActionButtonsWordle({
    super.key,
    required this.isStageCompleted,
    required this.isValid,
    required this.isWordContain,
    required this.hintMax,
  });

  @override
  Widget build(BuildContext context) {
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
                ? () {
                    if (isStageCompleted) {
                      Navigator.popAndPushNamed(context, WordlePage.route);
                    } else {
                      context.read<WordleProvider>().onSubmitButton();
                    }
                    if (isWordContain) {
                      Fluttertoast.showToast(
                          msg: "Kata Tidak Ada",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor:
                              Theme.of(context).colorScheme.onError,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
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
  }
}


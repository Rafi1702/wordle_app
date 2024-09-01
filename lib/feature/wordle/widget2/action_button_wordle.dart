import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tebak_kata/feature/wordle/cubit/wordle_cubit.dart';
import 'package:tebak_kata/feature/wordle/presentation/wordle_page.dart';


class ActionButtonsWordle extends StatelessWidget {
  const ActionButtonsWordle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordleCubit, WordleState>(
      buildWhen: (previous, current) =>
          previous.isStageCompleted != current.isStageCompleted ||
          previous.wordFactStatus != current.wordFactStatus ||
          previous.isValid != current.isValid ||
          previous.hintLimit != current.hintLimit,
      builder: (context, state) {
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
                onPressed: state.isValid &&
                        state.wordFactStatus != WordlePageStatus.loading
                    ? state.isStageCompleted
                        ? () => Navigator.of(context)
                            .pushReplacementNamed(WordlePage.route)
                        : () {
                            context.read<WordleCubit>().onSubmitButton();
                          }
                    : null,
                child: state.wordFactStatus == WordlePageStatus.loading
                    ? const SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Text(state.isStageCompleted ? 'Next' : 'Submit')),
            const Spacer(),
            ElevatedButton(
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(
                  CircleBorder(),
                ),
              ),
              onPressed: state.isStageCompleted
                  ? null
                  : () {
                      context.read<WordleCubit>().onHintButton();
                    },
              child: Icon(state.hintLimit <= 0 ? Icons.flag : Icons.lightbulb_rounded,
                  color:state.hintLimit <= 0 ? Colors.white : Colors.yellow,
                  size: 30.0),
            )
          ],
        );
      },
    );
  }
}

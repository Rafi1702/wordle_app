import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tebak_kata/feature/wordle/cubit/wordle_cubit.dart';

class HintWordSection extends StatelessWidget {
  const HintWordSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WordleCubit, WordleState, List<String>>(
      selector: (state) {
        return state.hintWord;
      },
      builder: (context, state) {
        return Wrap(
            runSpacing: 10.0,
            spacing: 10.0,
            children: state
                .map(
                  (e) => Container(
                    width: 20.0,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 4.0,
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        e,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                )
                .toList());
      },
    );
  }
}

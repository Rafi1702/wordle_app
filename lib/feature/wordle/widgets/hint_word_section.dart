import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/feature/wordle/providers/wordle_provider.dart';

class HintWordSection extends StatelessWidget {
  const HintWordSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hintWord = context
        .select((WordleProvider wordleProvider) => wordleProvider.hintWord);

    return Wrap(
        runSpacing: 10.0,
        spacing: 10.0,
        children: hintWord
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
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            )
            .toList());
  }
}

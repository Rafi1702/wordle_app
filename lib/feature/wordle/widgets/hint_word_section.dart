import 'package:flutter/material.dart';

class HintWord extends StatelessWidget {
  final List<String> hintWord;
  const HintWord({
    required this.hintWord,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                            width: 1.0,
                            color: Theme.of(context).colorScheme.onSurface))),
                child: Center(
                  child: Text(
                    e,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
            )
            .toList());
  }
}

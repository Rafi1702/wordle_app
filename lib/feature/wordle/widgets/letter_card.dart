import 'package:flutter/material.dart';

class LetterCard extends StatelessWidget {
  const LetterCard({
    super.key,
    required this.letter,
    this.color,
  });

  final String letter;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      width: 60.0,
      child: Card(
        color: color,
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

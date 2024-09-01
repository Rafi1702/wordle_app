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
    final width = MediaQuery.sizeOf(context).width / 6;
    final height = MediaQuery.sizeOf(context).height / 12;
    // log(MediaQuery.sizeOf(context).width.toString());
    return SizedBox(
      height: height,
      width: width,
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

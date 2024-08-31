import 'package:flutter/material.dart';

import 'package:tebak_kata/helper/qwerty.dart';

class KeyPad extends StatelessWidget {
  final QwertyKey qwertyKey;
  final void Function(String) onTapped;
  const KeyPad({super.key, required this.qwertyKey, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width / 12;

    return GestureDetector(
      onTap: () => onTapped(qwertyKey.name.toUpperCase()),
      child: Container(
        decoration: BoxDecoration(
          color: qwertyKey == QwertyKey.delete
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 50.0,
        width: qwertyKey == QwertyKey.delete ? width + 20 : width,
        child: Center(
          child: Text(
            qwertyKey == QwertyKey.delete
                ? qwertyKey.name
                : qwertyKey.name.toUpperCase(),
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}

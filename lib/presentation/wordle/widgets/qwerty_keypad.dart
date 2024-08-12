import 'package:flutter/material.dart';
import 'package:tebak_kata/helper/app_theme.dart';
import 'package:tebak_kata/helper/qwerty.dart';

class KeyPad extends StatelessWidget {
  final QwertyKey qwertyKey;
  final void Function(String) onTapped;
  const KeyPad({super.key, required this.qwertyKey, required this.onTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:
          qwertyKey == QwertyKey.delete ? null : () => onTapped(qwertyKey.name),
      child: Container(
        decoration: BoxDecoration(
          color: qwertyKey == QwertyKey.delete
              ? Colors.red
              : AppTheme.gridBoxColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 50.0,
        width: qwertyKey == QwertyKey.delete ? 50.0 : 33.0,
        child: Center(
          child: Text(qwertyKey.name),
        ),
      ),
    );
  }
}

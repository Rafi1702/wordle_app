import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/feature/wordle/cubit/wordle_cubit.dart';

import 'package:tebak_kata/feature/wordle/widget2/qwerty_keypad.dart';
import 'package:tebak_kata/helper/qwerty.dart';

class KeyBoard extends StatelessWidget {
  const KeyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyPad(
              qwertyKey: QwertyKey.q,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.w,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.e,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.r,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.t,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.y,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.u,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.i,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.o,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.p,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyPad(
              qwertyKey: QwertyKey.a,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.s,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.d,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.f,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.g,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.h,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.j,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.k,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.l,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KeyPad(
              qwertyKey: QwertyKey.z,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.x,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.c,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.v,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.b,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.n,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
              qwertyKey: QwertyKey.m,
              onTapped: (val) =>
                  context.read<WordleCubit>().onWordChanged(val),
            ),
            const SizedBox(width: 4.0),
            KeyPad(
                qwertyKey: QwertyKey.delete,
                onTapped: (_) {
                  context.read<WordleCubit>().onDeleteCharacter();
                }),
          ],
        )
      ],
    );
  }
}

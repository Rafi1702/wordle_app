import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/helper/app_theme.dart';
import 'package:tebak_kata/helper/qwerty.dart';
import 'package:tebak_kata/providers/audio_provider.dart';

import 'package:tebak_kata/providers/wordle_provider.dart';

class WordlePage extends StatelessWidget {
  static const route = '/';
  const WordlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.0,
        title: const Text('Wordle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog<double>(
                context: context,
                builder: (BuildContext context) => const CustomDialog(),
              );
            },
          )
        ],
      ),
      body: Consumer<WordleProvider>(
        builder: (context, state, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ...List<Widget>.generate(
              6,
              (i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(4, (j) {
                      return Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: colorHelper(state.guessedWord[i][j].status),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                            child:
                                Text(state.guessedWord[i][j].character ?? '')),
                      );
                    }),
                  ),
                );
              },
            ),
            state.stageStatus == StageStatus.complete
                ? ElevatedButton(
                    style: ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              4.0,
                            ),
                          ),
                        ),
                        backgroundColor:
                            const WidgetStatePropertyAll(Colors.green)),
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(WordlePage.route);
                    },
                    child: const Text('Next'))
                : ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            4.0,
                          ),
                        ),
                      ),
                      backgroundColor: state.isValid
                          ? const WidgetStatePropertyAll(Colors.green)
                          : null,
                    ),
                    onPressed: state.isValid
                        ? () => context.read<WordleProvider>().onSubmitButton()
                        : null,
                    child: const Text(
                      'Submit',
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _KeyPad(
                  qwertyKey: QwertyKey.q,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.w,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.e,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.r,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.t,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.y,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.u,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.i,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.o,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.p,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _KeyPad(
                  qwertyKey: QwertyKey.a,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.s,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.d,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.f,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.g,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.h,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.j,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.k,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.l,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _KeyPad(
                  qwertyKey: QwertyKey.z,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.x,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.c,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.v,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.b,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.n,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.m,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
                const SizedBox(width: 4.0),
                _KeyPad(
                  qwertyKey: QwertyKey.delete,
                  onTapped: (val) =>
                      context.read<WordleProvider>().onWordChanged(val),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color? colorHelper(CharacterStatus? status) {
    switch (status) {
      case CharacterStatus.exist:
        return Colors.green;
      case CharacterStatus.existDifferentIndex:
        return Colors.yellow;
      default:
        return AppTheme.gridBoxColor;
    }
  }
}

class _KeyPad extends StatelessWidget {
  final QwertyKey qwertyKey;
  final void Function(String) onTapped;
  const _KeyPad({required this.qwertyKey, required this.onTapped});

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

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioState = context.watch<AudioProvider>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Slider(
                max: 1.0,
                label: audioState.volume.toString(),
                divisions: 5,
                value: audioState.volume,
                onChanged: (double _) =>
                    context.read<AudioProvider>().onVolumeChange(_)),
            Text('${audioState.volume}'),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

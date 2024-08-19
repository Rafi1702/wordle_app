import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tebak_kata/helper/qwerty.dart';
import 'package:tebak_kata/presentation/settings/widgets/settings_dialog.dart';
import 'package:tebak_kata/presentation/wordle/widgets/qwerty_keypad.dart';

import 'package:tebak_kata/presentation/wordle/providers/wordle_provider.dart';

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
        builder: (context, state, child) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.guessedWord.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20.0,
                    );
                  },
                  itemBuilder: (context, triedIndex) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List<Widget>.generate(4, (j) {
                          return SizedBox(
                            height: 60.0,
                            width: 60.0,
                            child: Card(
                              color: colorHelper(
                                  state.guessedWord[triedIndex][j].status,
                                  context),
                              child: Center(
                                child: Text(
                                  state.guessedWord[triedIndex][j].character ??
                                      '',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
              Row(
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  ElevatedButton(
                      onPressed: state.isValid
                          ? () {
                              if (state.stageStatus == StageStatus.complete) {
                                Navigator.of(context).popAndPushNamed(route);
                              } else {
                                context.read<WordleProvider>().onSubmitButton();
                              }
                            }
                          : null,
                      child: Text(state.stageStatus == StageStatus.complete
                          ? 'Next'
                          : 'Submit')),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: state.hintMax == 0
                          ? null
                          : () {
                              context.read<WordleProvider>().onHintTextTap();
                            },
                      child: const Text('Hint Text'))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KeyPad(
                    qwertyKey: QwertyKey.q,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.w,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.e,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.r,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.t,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.y,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.u,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.i,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.o,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.p,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
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
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.s,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.d,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.f,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.g,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.h,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.j,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.k,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.l,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
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
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.x,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.c,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.v,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.b,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.n,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                    qwertyKey: QwertyKey.m,
                    onTapped: (val) =>
                        context.read<WordleProvider>().onWordChanged(val),
                  ),
                  const SizedBox(width: 4.0),
                  KeyPad(
                      qwertyKey: QwertyKey.delete,
                      onTapped: (_) {
                        context.read<WordleProvider>().onDeleteCharacter();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Color? colorHelper(CharacterStatus? status, BuildContext context) {
    switch (status) {
      case CharacterStatus.exist:
        return Colors.green;
      case CharacterStatus.existDifferentIndex:
        return const Color(0xFFFFD700);
      default:
        return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/helper/qwerty.dart';
import 'package:tebak_kata/providers/wordle_provider.dart';

class WordlePage extends StatelessWidget {
  static const route = '/';
  const WordlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Wordle"),
      ),
      body: Consumer<WordleProvider>(
        builder: (context, state, child) => Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(
              6,
              (i) {
                return Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  children: List<Widget>.generate(4, (j) {
                    return Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: colorHelper(state.guessedWord[i][j].status),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Center(
                          child: Text(state.guessedWord[i][j].character ?? '')),
                    );
                  }),
                );
              },
            )..addAll(
                [
                  ElevatedButton(
                    onPressed: state.isValid
                        ? () {
                            if (state.stageStatus == StageStatus.complete) {
                              Navigator.of(context)
                                  .popAndPushNamed(WordlePage.route);
                            } else {
                              context.read<WordleProvider>().onSubmitButton();
                            }
                          }
                        : null,
                    child: state.stageStatus == StageStatus.complete
                        ? const Text('Next')
                        : const Text('Submit'),
                  ),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: List.generate(QwertyKey.values.length, (index) {
                      return InkWell(
                        onTap: QwertyKey.values[index] == QwertyKey.delete
                            ? null
                            : () {
                                context.read<WordleProvider>().onWordChanged(
                                    QwertyKey.values[index].name);
                              },
                        child: Container(
                          color: Colors.amber,
                          height: 30.0,
                          width: 40.0,
                          child: Center(
                            child: Text(QwertyKey.values[index].name),
                          ),
                        ),
                      );
                    }),
                  )
                ],
              ),
          ),
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
        return Colors.amber;
    }
  }
}


// TextField(
//                           readOnly: state.index != i,
//                           decoration: const InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderSide: BorderSide.none)),
//                           textAlign: TextAlign.center,
//                           onChanged: (value) {
//                             if (value.isEmpty) {
//                               return;
//                             }
//                             context.read<WordleProvider>().onWordChanged(value);
//                             FocusScope.of(context).nextFocus();
//                           }),
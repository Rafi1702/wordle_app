import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/providers/wordle_provider.dart';

class WordlePage extends StatelessWidget {
  const WordlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Wordle"),
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
                  key: ValueKey(i),
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  children: List<Widget>.generate(4, (j) {
                    return Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: state.guessedWord.isNotEmpty && i == 0
                              ? colorHelper(state.guessedWord[i][j].status)
                              : Colors.amber,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: TextField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            print(value);
                            // if(value.isEmpty){

                            // }
                            context.read<WordleProvider>().onWordChanged(value);
                          }),
                    );
                  }),
                );
              },
            )..add(ElevatedButton(
                onPressed: state.isValid
                    ? () {
                        context.read<WordleProvider>().onSubmitButton();
                      }
                    : null,
                child: Text('Submit'),
              )),
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

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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  direction: Axis.horizontal,
                  children: List<Widget>.generate(4, (j) {
                    return Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                          color: state.guessedWord[j][0].status ==
                                  CharacterStatus.notExist
                              ? Colors.amber
                              : Colors.green,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none)),
                          textAlign: TextAlign.center,
                          onChanged: (value) {
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

  // List<Color> colorHelper(
  //     int indexAt, List<List<CharacterModels>> list, CharacterStatus? status) {
  //  var colors = [];
  //   for (int i = 0; i < list.length; i++) {
  //     if(list[i][])
  //     colors[i].add()
  //   }
  //   switch (status) {
  //     case CharacterStatus.exist:
  //       return Colors.green;
  //     case CharacterStatus.existDifferentIndex:
  //       return Colors.yellow;
  //     default:
  //       return Colors.amber;
  //   }
  // }
}

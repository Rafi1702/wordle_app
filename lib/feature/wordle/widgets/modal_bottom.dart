import 'package:flutter/material.dart';
import 'package:tebak_kata/domain/models/word_fact.dart';

class WordFactsBottomModal extends StatelessWidget {
  final List<WordFact> wordFacts;
  const WordFactsBottomModal({
    required this.wordFacts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => ListView(
        controller: scrollController,
        children: <Widget>[
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: wordFacts.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, wordFactsIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(wordFacts[wordFactsIndex].phonetic),
                      IconButton(
                        icon: const Icon(Icons.volume_up),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Wrap(
                    spacing: 10.0,
                    children: wordFacts[wordFactsIndex].meanings.map((e) {
                      return Text(e.partOfSpeech);
                    }).toList(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: wordFacts[wordFactsIndex].meanings.expand(
                      (e) {
                        return e.definitions.map((t) {
                          return Text(t.definition);
                        }).toList();
                      },
                    ).toList(),
                  ),
                ],
              );
            },
          ),
          ...List.generate(
            10,
            (index) => Text('e'),
          )
        ],
      ),
    );
  }
}

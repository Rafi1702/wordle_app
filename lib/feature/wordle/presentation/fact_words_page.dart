import 'package:flutter/material.dart';
import 'package:tebak_kata/domain/models/word_fact.dart';

class FactWordsPage extends StatelessWidget {
  static const route = '/fact_words';

  const FactWordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleTextStyle = Theme.of(context).textTheme.titleLarge;
    final wordFacts =
        ModalRoute.of(context)?.settings.arguments as List<WordFact>;
    return Scaffold(
      appBar: AppBar(title: const Text('Word Facts')),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
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
                      Text( 'Not Available',
                          style: titleTextStyle),
                      IconButton(
                        icon: const Icon(Icons.volume_up),
                        onPressed: () {},
                      )
                    ],
                  ),
                  Wrap(
                    spacing: 4.0,
                    children: wordFacts[wordFactsIndex].meanings.map((e) {
                      return Chip(label: Text(e.partOfSpeech));
                    }).toList(),
                  ),
                  ...wordFacts[wordFactsIndex].meanings.map(
                    (e) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Meanings'),
                            const SizedBox(height: 4.0),
                            ...e.definitions.asMap().entries.map((e) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${e.key + 1}. '),
                                  Expanded(
                                    child: Text(
                                      e.value.definition,
                                    ),
                                  ),
                                ],
                              );
                            }),
                            const SizedBox(height: 8.0),
                          ]);
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

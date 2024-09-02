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
              List<Phonetic> phonetics = wordFacts[wordFactsIndex].phonetics;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Word ${wordFactsIndex + 1}'),
                  Row(
                    children: [
                      Text(
                          phonetics.isNotEmpty
                              ? phonetics.first.text ?? ''
                              : 'Unavailable',
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
                  ExpansionTile(
                    title: const Text('Meanings'),
                    children:
                        wordFacts[wordFactsIndex].meanings.asMap().entries.map(
                      (entry) {
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Meanings ${entry.key + 1}'),
                              const SizedBox(height: 4.0),
                              ...entry.value.definitions.asMap().entries.map(
                                (e) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${e.key + 1}. '),
                                      Expanded(
                                        child: Text(
                                          e.value.definition,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(height: 8.0),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

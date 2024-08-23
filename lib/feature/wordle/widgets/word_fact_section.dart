import 'package:flutter/material.dart';
import 'package:tebak_kata/domain/models/word_fact.dart';
import 'package:tebak_kata/feature/wordle/presentation/fact_words_page.dart';

class WordFactsSection extends StatelessWidget {
  final List<WordFact> wordFacts;
  final bool isLoading;
  const WordFactsSection(
      {super.key, required this.wordFacts, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final basetextStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(color: Theme.of(context).colorScheme.onPrimary);
    final titleTextStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Theme.of(context).colorScheme.onPrimary);
    final iconColor = Theme.of(context).colorScheme.onPrimary;
    return Center(
      child: isLoading
          ? const CircularProgressIndicator()
          : GestureDetector(
              onTap: () {
                // showModalBottomSheet<void>(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return WordFactsBottomModal(
                //         wordFacts: wordFacts,
                //       );
                //     });
                Navigator.of(context)
                    .pushNamed(FactWordsPage.route, arguments: wordFacts);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: Theme.of(context).colorScheme.onSurface),
                child: wordFacts.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(wordFacts.first.phonetic,
                                  style: titleTextStyle),
                              IconButton(
                                icon: Icon(
                                  Icons.volume_up,
                                  color: iconColor,
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                          Text(wordFacts.first.meanings.first.partOfSpeech,
                              style: basetextStyle),
                          Text(
                              wordFacts.first.meanings.first.definitions.first
                                  .definition,
                              style: basetextStyle),
                        ],
                      )
                    : Text(
                        'Belum ada faktanya',
                        style: basetextStyle,
                      ),
              ),
            ),
    );
  }
}

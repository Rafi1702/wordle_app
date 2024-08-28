import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tebak_kata/feature/wordle/presentation/fact_words_page.dart';
import 'package:tebak_kata/feature/wordle/providers/wordle_provider.dart';

class WordFactsSection extends StatelessWidget {
  const WordFactsSection({
    super.key,
  });

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
    return Builder(builder: (context) {
      final status = context
          .select((WordleProvider wordleProvider) => wordleProvider.status);
      final wordFact = context
          .select((WordleProvider wordleProvider) => wordleProvider.wordFact);
      final wordFactError = context.select(
          (WordleProvider wordleProvider) => wordleProvider.wordFactError);
      if (wordFactError.isEmpty) {
        return Center(
          child: status == WordleStatus.loading
              ? const CircularProgressIndicator()
              : GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(FactWordsPage.route, arguments: wordFact);
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
                    child: wordFact.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(wordFact.first.phonetic,
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
                              Text(wordFact.first.meanings.first.partOfSpeech,
                                  style: basetextStyle),
                              Text(
                                  wordFact.first.meanings.first.definitions
                                      .first.definition,
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
      return Column(
        children: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<WordleProvider>().getWordFacts();
            },
          ),
          Text(wordFactError),
        ],
      );
    });
  }
}

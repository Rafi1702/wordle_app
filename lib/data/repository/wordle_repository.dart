import 'package:tebak_kata/data/datasource/facts_word_remote.dart';
import 'package:tebak_kata/data/datasource/random_word_remote.dart';
import 'package:tebak_kata/data/models/word_fact.dart';

class WordleRepository {
  final RandomWordRemote randomWordRemote;
  final FactsWordRemote factsWordRemote;
  WordleRepository(
      {required this.randomWordRemote, required this.factsWordRemote});
  Future<List<WordFact>> getRandomWord() async {
    final word = await randomWordRemote.getWord();

    final wordFacts = await factsWordRemote.getWordFacts(word);

    return wordFacts;
  }
}

import 'package:tebak_kata/data/remote/facts_word_remote.dart';
import 'package:tebak_kata/data/remote/random_word_remote.dart';
import 'package:tebak_kata/domain/models/word_fact.dart';

class WordleRepository {
  final RandomWordRemote randomWordRemote;
  final FactsWordRemote factsWordRemote;
  WordleRepository(
      {required this.randomWordRemote, required this.factsWordRemote});

  Future<String> getRandomWord() async {
    final word = await randomWordRemote.getWord();
    return word;
  }

  Future<List<WordFact>> getWordFact(String word) async {
    final wordFacts = await factsWordRemote.getWordFacts(word);

    return wordFacts;
  }
}

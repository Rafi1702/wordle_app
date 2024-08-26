import 'package:tebak_kata/data/remote/facts_word_remote.dart';
import 'package:tebak_kata/data/local/random_word_remote.dart';
import 'package:tebak_kata/domain/models/word_fact.dart';

class WordleRepository {
  final RandomWordLocal randomWordRemote;
  final FactsWordRemote factsWordRemote;
  WordleRepository(
      {required this.randomWordRemote, required this.factsWordRemote});

  Future<List<String>> getRandomWord() async {
    final word = await randomWordRemote.getWord();
    return await Future.delayed(const Duration(seconds: 10),
        () => word.where((e) => e.length == 4 || e.length == 5).toList());
  }

  Future<List<WordFact>> getWordFact(String word) async {
    final wordFacts = await factsWordRemote.getWordFacts(word);

    return wordFacts;
  }
}

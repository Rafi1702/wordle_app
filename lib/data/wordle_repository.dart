import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tebak_kata/data/models/word_fact.dart';

class WordleRepository {
  Future<List<WordFact>> getRandomWord() async {
    final word = await http.get(
        Uri.parse("https://random-word-form.herokuapp.com/random/adjective"));

    final wordFacts = await http.get(Uri.parse(
        "https://api.dictionaryapi.dev/api/v2/entries/en/${jsonDecode(word.body).first}"));

    return (jsonDecode(wordFacts.body) as List)
        .map((e) => WordFact.fromJson(e))
        .toList();
  }
}

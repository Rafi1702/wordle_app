import 'dart:convert';

import 'package:tebak_kata/domain/models/word_fact.dart';
import 'package:http/http.dart' as http;

class FactsWordRemote {
  Future<List<WordFact>> getWordFacts(String word) async {
    final response = await http.get(
        Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"));

    return (jsonDecode(response.body) as List)
        .map((e) => WordFact.fromJson(e))
        .toList();
  }
}

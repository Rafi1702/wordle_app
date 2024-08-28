import 'dart:convert';
import 'dart:io';

import 'package:tebak_kata/domain/models/word_fact.dart';
import 'package:http/http.dart' as http;

class FactsWordRemote {
  Future<List<WordFact>> getWordFacts(String word) async {
    try {
      final response = await http
          .get(
            Uri.parse("https://api.dictionaryapi.dev/api/v2/entries/en/$word"),
          )
          .timeout(const Duration(seconds: 10));

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decodedResponse as List)
            .map((e) => WordFact.fromJson(e))
            .toList();
      }
      throw Exception('Penjelasan kata tidak dapat ditemukan');
    } on SocketException catch (_) {
      throw Exception('Koneksi Internet Bermasalah');
    }
  }
}

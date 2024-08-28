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
          .timeout(const Duration(seconds: 3));

      return (jsonDecode(response.body) as List)
          .map((e) => WordFact.fromJson(e))
          .toList();
    } on SocketException catch (_) {
      throw Exception('Koneksi Internet Bermasalah');
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

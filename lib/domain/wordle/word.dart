import 'dart:convert';

import 'package:http/http.dart' as http;

class WordleRepository {
  Future<void> getRandomWord() async {
    final word = await http.get(
        Uri.parse("https://random-word-form.herokuapp.com/random/adjective"));

    final response = await http.get(Uri.parse(
        "https://api.dictionaryapi.dev/api/v2/entries/en/${jsonDecode(word.body).first}"));

    print(jsonDecode(response.body));
  }
}

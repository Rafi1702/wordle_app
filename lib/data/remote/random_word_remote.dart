import 'dart:convert';

import 'package:http/http.dart' as http;

class RandomWordRemote {
  Future<String> getWord() async {
    final response = await http.get(
        Uri.parse("https://random-word-api.herokuapp.com/word?length=5"));

    return (jsonDecode(response.body) as List).first;
  }
}

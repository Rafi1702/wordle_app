import 'dart:convert';

import 'package:flutter/services.dart';

class RandomWordLocal {
  Future<List<String>> getWord() async {
    final words = await rootBundle.loadString('assets/words.json');

    return List<String>.from(jsonDecode(words));
  }
}

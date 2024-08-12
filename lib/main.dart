import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/presentation/wordle_page.dart';
import 'package:tebak_kata/providers/audio_provider.dart';
import 'package:tebak_kata/providers/wordle_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // lazy: false,
      create: (BuildContext context) {
        return AudioProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
          ),
          routes: {
            WordlePage.route: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) {
                    return WordleProvider();
                  },
                  child: const WordlePage(),
                ),
          }),
    );
  }
}

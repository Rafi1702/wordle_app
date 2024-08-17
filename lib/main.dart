import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tebak_kata/presentation/wordle/wordle_page.dart';
import 'package:tebak_kata/global_state/settings_provider.dart';
import 'package:tebak_kata/presentation/wordle/providers/wordle_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (BuildContext context) {
        return SettingsProvider();
      },
      child: Builder(builder: (context) {
        final state = context.watch<SettingsProvider>();
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.selectedTheme,
            routes: {
              WordlePage.route: (context) => ChangeNotifierProvider(
                    create: (BuildContext context) {
                      return WordleProvider();
                    },
                    child: const WordlePage(),
                  ),
            });
      }),
    );
  }
}

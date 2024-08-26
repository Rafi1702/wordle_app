import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tebak_kata/data/local/audio_local_storage.dart';
import 'package:tebak_kata/data/remote/facts_word_remote.dart';
import 'package:tebak_kata/data/local/random_word_remote.dart';
import 'package:tebak_kata/data/local/theme_local_storage.dart';
import 'package:tebak_kata/domain/repository/settings_repository.dart';
import 'package:tebak_kata/domain/repository/wordle_repository.dart';
import 'package:tebak_kata/feature/wordle/presentation/fact_words_page.dart';
import 'package:tebak_kata/feature/wordle/presentation/wordle_page.dart';
import 'package:tebak_kata/feature/wordle/providers/wordle_provider.dart';

import 'package:tebak_kata/helper/app_theme.dart';

import 'package:tebak_kata/feature/settings/providers/settings_provider.dart';

const themeKey = "__theme__";
const volumeKey = "___volume___";
const bgmKey = "___bgm___";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferencesWithCache prefsWithCache =
      await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{themeKey, volumeKey, bgmKey},
    ),
  );

  final randomWordRemote = RandomWordLocal();
  final factWordRemote = FactsWordRemote();
  final themeLocalStorage =
      ThemeLocalStorage(pref: prefsWithCache, key: themeKey);
  final audioLocalStorage = AudioLocalStorage(
      pref: prefsWithCache, volumeKey: volumeKey, bgmKey: bgmKey);

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => WordleRepository(
              randomWordRemote: randomWordRemote,
              factsWordRemote: factWordRemote),
        ),
        Provider(
          create: (context) => SettingsRepository(
            themeLocalStorage: themeLocalStorage,
            audioLocalStorage: audioLocalStorage,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (BuildContext context) {
        return SettingsProvider(
            settingsRepository: context.read<SettingsRepository>());
      },
      child: Builder(builder: (context) {
        final state = context.watch<SettingsProvider>();
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.selectedTheme.getThemeData,
            routes: {
              WordlePage.route: (context) => ChangeNotifierProvider(
                    create: (BuildContext context) {
                      return WordleProvider(
                          wordleRepo: context.read<WordleRepository>());
                    },
                    child: const WordlePage(),
                  ),
              FactWordsPage.route: (context) => const FactWordsPage(),
            });
      }),
    );
  }
}

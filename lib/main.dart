import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tebak_kata/data/local/audio_local_storage.dart';
import 'package:tebak_kata/data/remote/facts_word_remote.dart';
import 'package:tebak_kata/data/local/random_word_remote.dart';
import 'package:tebak_kata/data/local/theme_local_storage.dart';
import 'package:tebak_kata/domain/repository/settings_repository.dart';
import 'package:tebak_kata/domain/repository/wordle_repository.dart';
import 'package:tebak_kata/feature/settings/cubit/settings_cubit.dart';
import 'package:tebak_kata/feature/wordle/cubit/wordle_cubit.dart';
import 'package:tebak_kata/feature/wordle/presentation/fact_words_page.dart';
import 'package:tebak_kata/feature/wordle/presentation/wordle_page.dart';

import 'package:tebak_kata/helper/app_theme.dart';

import 'package:tebak_kata/home_page.dart';

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
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => WordleRepository(
              randomWordRemote: randomWordRemote,
              factsWordRemote: factWordRemote),
        ),
        RepositoryProvider(
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
    return BlocProvider<SettingsCubit>(
      create: (context) {
        return SettingsCubit(
          settingsRepository: context.read<SettingsRepository>(),
        )..initialSettings();
      },
      child: BlocSelector<SettingsCubit, SettingsState, Themes>(
          selector: (state) => state.theme,
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.getThemeData,
              routes: {
                HomePage.route: (context) => const HomePage(),
                WordlePage2.route: (context) => BlocProvider(
                      create: (context) => WordleCubit(
                          wordleRepository: context.read<WordleRepository>())
                        ..getWord(),
                      child: const WordlePage2(),
                    ),
                FactWordsPage.route: (context) => const FactWordsPage(),
              },
            );
          }),
    );
  }
}

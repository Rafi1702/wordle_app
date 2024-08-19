import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tebak_kata/data/theme_local_storage.dart';
import 'package:tebak_kata/data/wordle_repository.dart';
import 'package:tebak_kata/helper/app_theme.dart';

import 'package:tebak_kata/presentation/wordle/wordle_page.dart';
import 'package:tebak_kata/global_state/settings_provider.dart';
import 'package:tebak_kata/presentation/wordle/providers/wordle_provider.dart';

const key = "__theme__";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferencesWithCache prefsWithCache =
      await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(
      allowList: <String>{key},
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => WordleRepository(),
        ),
        Provider(
          create: (context) =>
              ThemeLocalStorage(pref: prefsWithCache, key: key),
        )
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
        return SettingsProvider(themeLocal: context.read<ThemeLocalStorage>());
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
            });
      }),
    );
  }
}

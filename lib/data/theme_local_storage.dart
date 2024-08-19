import 'package:shared_preferences/shared_preferences.dart';

class ThemeLocalStorage {
  final SharedPreferencesWithCache pref;
  final String key;

  ThemeLocalStorage({required this.pref, required this.key});

  int getlocalTheme() {
    final theme = pref.getInt(key);
    return theme ?? 0;
  }

  Future<void> setLocalTheme(int appTheme) async {
    await pref.setInt(key, appTheme);
  }
}

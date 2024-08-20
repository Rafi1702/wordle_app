import 'package:tebak_kata/data/local/audio_local_storage.dart';
import 'package:tebak_kata/data/local/theme_local_storage.dart';

class SettingsRepository {
  final ThemeLocalStorage themeLocalStorage;
  final AudioLocalStorage audioLocalStorage;

  const SettingsRepository(
      {required this.themeLocalStorage, required this.audioLocalStorage});
}

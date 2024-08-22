import 'package:tebak_kata/data/local/audio_local_storage.dart';
import 'package:tebak_kata/data/local/theme_local_storage.dart';

class SettingsRepository {
  final ThemeLocalStorage themeLocalStorage;
  final AudioLocalStorage audioLocalStorage;

  const SettingsRepository(
      {required this.themeLocalStorage, required this.audioLocalStorage});

  double get volume => audioLocalStorage.getVolume();

  bool get bgmValue => audioLocalStorage.getBgmValue();

  int get localTheme => themeLocalStorage.getlocalTheme();

  Future<void> setVolume(double volume) async {
    await audioLocalStorage.setVolume(volume);
  }

  Future<void> setBgmValue(bool value) async {
    await audioLocalStorage.setBgmValue(value);
  }

  Future<void> setLocalTheme(int appTheme) async {
    await themeLocalStorage.setLocalTheme(appTheme);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class AudioLocalStorage {
  final SharedPreferencesWithCache pref;
  final String volumeKey;
  final String bgmKey;

  const AudioLocalStorage(
      {required this.pref, required this.volumeKey, required this.bgmKey});

  double getVolume() {
    final volume = pref.getDouble(volumeKey);

    return volume ?? 0.0;
  }

  bool getBgmValue() {
    final isBgmMute = pref.getBool(bgmKey);

    return isBgmMute ?? false;
  }

  Future<void> setVolume(double volume) async {
    await pref.setDouble(volumeKey, volume);
  }

  Future<void> setBgmValue(bool value) async {
    await pref.setBool(bgmKey, value);
  }
}

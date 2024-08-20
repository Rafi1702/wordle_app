import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tebak_kata/data/local/audio_local_storage.dart';
import 'package:tebak_kata/data/local/theme_local_storage.dart';
import 'package:tebak_kata/helper/app_theme.dart';

class SettingsProvider with ChangeNotifier {
  final ThemeLocalStorage themeLocal;
  final AudioLocalStorage audioLocal;

  PlayerState _playerState = PlayerState.playing;
  PlayerState get playerState => _playerState;

  bool _isBgmActive = true;
  bool get isBgmActive => _isBgmActive;

  final AudioPlayer _player = AudioPlayer();
  late StreamSubscription playerStateChange;

  double _volume = 0.05;
  double get volume => _volume;

  Themes _selectedTheme = Themes.sakuraTheme;
  Themes get selectedTheme => _selectedTheme;

  SettingsProvider({required this.themeLocal, required this.audioLocal}) {
    onInitialSettings();
    // playAudio();
    // playerStateChange = _player.onPlayerStateChanged.listen((state) {
    //   onPlayerStateChanged(state);
    // });

    // playerStateChange = _player.onPlayerComplete.listen((state) {
    //   playAudio();
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // playerStateChange.cancel();
    super.dispose();
  }

  void onInitialSettings() {
    final volumeValue = audioLocal.getVolume();
    final isBgmMute = audioLocal.getBgmValue();
    final int themeIndex = themeLocal.getlocalTheme();
    _selectedTheme = Themes.values[themeIndex];
    _volume = volumeValue;
    _isBgmActive = isBgmMute;

    notifyListeners();
  }

  void onPlayerStateChanged(PlayerState state) {
    _playerState = state;
    notifyListeners();
  }

  Future<void> playAudio() async {
    await _player.play(
      AssetSource('arcade-party.mp3'),
      volume: _volume,
    );
  }

  Future<void> onResumeAudio() async {
    await _player.resume();
  }

  Future<void> onPauseAudio() async {
    await _player.pause();
  }

  Future<void> onVolumeChange(double value) async {
    _volume = value;

    await Future.wait(
      [
        _player.setVolume(_volume),
        audioLocal.setVolume(_volume),
      ],
    );

    notifyListeners();
  }

  Future<void> onBgmCheckBoxTap() async {
    _isBgmActive = !_isBgmActive;

    await Future.wait(
      [
        _isBgmActive ? _player.setVolume(_volume) : _player.setVolume(0),
        audioLocal.setBgmValue(_isBgmActive),
      ],
    );

    notifyListeners();
  }

  Future<void> onThemeChange(Themes theme) async {
    if (theme == _selectedTheme) {
      return;
    }
    await themeLocal.setLocalTheme(theme.index);

    _selectedTheme = theme;

    notifyListeners();
  }
}

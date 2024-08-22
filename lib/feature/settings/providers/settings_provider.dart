import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:tebak_kata/domain/repository/settings_repository.dart';
import 'package:tebak_kata/helper/app_theme.dart';

class SettingsProvider with ChangeNotifier {
  final SettingsRepository settingsRepository;

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

  SettingsProvider({required this.settingsRepository}) {
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
    final volumeValue = settingsRepository.volume;
    final isBgmMute = settingsRepository.bgmValue;
    final themeIndex = settingsRepository.localTheme;
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
        settingsRepository.setVolume(_volume),
      ],
    );

    notifyListeners();
  }

  Future<void> onBgmCheckBoxTap() async {
    _isBgmActive = !_isBgmActive;

    await Future.wait(
      [
        _isBgmActive ? _player.setVolume(_volume) : _player.setVolume(0),
        settingsRepository.setBgmValue(_isBgmActive),
      ],
    );

    notifyListeners();
  }

  Future<void> onThemeChange(Themes theme) async {
    if (theme == _selectedTheme) {
      return;
    }
    await settingsRepository.setLocalTheme(theme.index);

    _selectedTheme = theme;

    notifyListeners();
  }
}

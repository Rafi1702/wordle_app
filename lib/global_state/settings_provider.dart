import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tebak_kata/helper/app_theme.dart';

class SettingsProvider with ChangeNotifier {
  PlayerState _playerState = PlayerState.playing;
  PlayerState get playerState => _playerState;

  bool _isBgmActive = true;
  bool get isBgmActive => _isBgmActive;

  final AudioPlayer _player = AudioPlayer();
  late StreamSubscription playerStateChange;

  double _volume = 0.05;
  double get volume => _volume;

  ThemeData _selectedTheme = AppTheme.darkTheme;
  ThemeData get selectedTheme => _selectedTheme;

  SettingsProvider() {
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

    await _player.setVolume(_volume);

    notifyListeners();
  }

  Future<void> onBgmCheckBoxTap() async {
    if (_isBgmActive) {
      await _player.setVolume(_volume);
      _isBgmActive = false;
    } else {
      await _player.setVolume(0);
      _isBgmActive = true;
    }

    notifyListeners();
  }

  void onThemeChange(ThemeData theme) {
    if (theme == _selectedTheme) {
      return;
    }
    _selectedTheme = theme;

    notifyListeners();
  }
}

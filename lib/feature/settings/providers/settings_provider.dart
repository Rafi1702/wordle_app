import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:tebak_kata/domain/repository/settings_repository.dart';
import 'package:tebak_kata/helper/app_theme.dart';

class SettingsProvider with ChangeNotifier {
  final SettingsRepository settingsRepository;

  PlayerState _bgmPlayerState = PlayerState.playing;
  PlayerState get bgmPlayerState => _bgmPlayerState;

  bool _isBgmActive = true;
  bool get isBgmActive => _isBgmActive;

  final AudioPlayer _bgmPlayer = AudioPlayer();
  late StreamSubscription playerStateChange;

  final AudioPlayer _translationPlayer = AudioPlayer();

  double _volume = 0.05;
  double get volume => _volume;

  Themes _selectedTheme = Themes.sakuraTheme;
  Themes get selectedTheme => _selectedTheme;

  SettingsProvider({required this.settingsRepository}) {
    onInitialSettings();
    // playAudio();
    // playerStateChange = _bgmPlayer.onPlayerStateChanged.listen((state) {
    //   onPlayerStateChanged(state);
    // });

    // playerStateChange = _bgmPlayer.onPlayerComplete.listen((state) {
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
    _bgmPlayerState = state;
    notifyListeners();
  }

  Future<void> playAudio() async {
    await _bgmPlayer.play(
      AssetSource('arcade-party.mp3'),
      volume: _volume,
    );
  }

  Future<void> playTranslation(String url) async {
    await _translationPlayer.play(UrlSource(url));
  }

  Future<void> onVolumeChange(double value) async {
    _volume = value;

    await Future.wait(
      [
        _bgmPlayer.setVolume(_volume),
        settingsRepository.setVolume(_volume),
      ],
    );

    notifyListeners();
  }

  Future<void> onBgmCheckBoxTap() async {
    _isBgmActive = !_isBgmActive;

    await Future.wait(
      [
        _isBgmActive ? _bgmPlayer.setVolume(_volume) : _bgmPlayer.setVolume(0),
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

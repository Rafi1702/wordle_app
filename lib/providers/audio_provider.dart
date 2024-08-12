import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider with ChangeNotifier {
  PlayerState _playerState = PlayerState.playing;

  PlayerState get playerState => _playerState;

  final AudioPlayer _player = AudioPlayer();

  late StreamSubscription playerStateChange;

  double _volume = 0.1;

  double get volume => _volume;

  AudioProvider() {
    playAudio();
    _player.onPlayerStateChanged.listen((state) {
      onPlayerStateChanged(state);
    });

    _player.onPlayerComplete.listen((state) {
      playAudio();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _player.dispose();
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
}

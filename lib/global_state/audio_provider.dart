import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioProvider with ChangeNotifier {
  PlayerState _playerState = PlayerState.playing;

  PlayerState get playerState => _playerState;

  final AudioPlayer _player = AudioPlayer();

  late StreamSubscription playerStateChange;

  late double _volume = 0;

  double get volume => _volume;

  AudioProvider() {
    playAudio();
    playerStateChange = _player.onPlayerStateChanged.listen((state) {
      onPlayerStateChanged(state);
    });

    playerStateChange = _player.onPlayerComplete.listen((state) {
      playAudio();
    });
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
    // if (value == 0.0) {
    //   _playerState = PlayerState.paused;
    // } else {
    //   _playerState = PlayerState.playing;
    // }
    await _player.setVolume(_volume);
    notifyListeners();
  }
}

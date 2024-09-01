import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tebak_kata/domain/repository/settings_repository.dart';
import 'package:tebak_kata/helper/app_theme.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.settingsRepository})
      : super(const SettingsState()) {
    _audioPlayer = AudioPlayer();
  }
  final SettingsRepository settingsRepository;
  late AudioPlayer _audioPlayer;

  void initialSettings() {
    final volumeValue = settingsRepository.volume;
    final isBgmMute = settingsRepository.bgmValue;
    final themeIndex = settingsRepository.localTheme;

    emit(
      state.copyWith(
        isBgmMute: isBgmMute,
        volume: volumeValue,
        theme: Themes.values[themeIndex],
      ),
    );
  }

  Future<void> playAudio() async {
    await _audioPlayer.play(
      AssetSource('arcade-party.mp3'),
      volume: state.volume,
    );
  }

  Future<void> onVolumeChange(double value) async {
    await Future.wait(
      [
        _audioPlayer.setVolume(state.volume),
        settingsRepository.setVolume(state.volume),
      ],
    );
    emit(state.copyWith(volume: value));
  }

  Future<void> onBgmCheckBoxTap() async {
    final isBgmMute = !state.isBgmMute;

    await Future.wait(
      [
        state.isBgmMute
            ? _audioPlayer.setVolume(state.volume)
            : _audioPlayer.setVolume(0),
        settingsRepository.setBgmValue(state.isBgmMute),
      ],
    );
    emit(state.copyWith(isBgmMute: isBgmMute));
  }

  Future<void> onThemeChange(Themes theme) async {
    await settingsRepository.setLocalTheme(theme.index);

    emit(state.copyWith(theme: theme));
  }
}

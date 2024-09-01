part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState(
      {this.isBgmMute = false,
      this.volume = 0,
      this.theme = Themes.sakuraTheme,
      this.playerState = PlayerState.playing});

  final bool isBgmMute;
  final double volume;
  final Themes theme;
  final PlayerState playerState;

  SettingsState copyWith(
          {bool? isBgmMute,
          double? volume,
          Themes? theme,
          PlayerState? playerState}) =>
      SettingsState(
        isBgmMute: isBgmMute ?? this.isBgmMute,
        volume: volume ?? this.volume,
        playerState: playerState ?? this.playerState,
        theme: theme ?? this.theme,
      );

  @override
  List<Object?> get props => [isBgmMute, volume, theme, playerState];
}

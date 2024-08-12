import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/global_state/audio_provider.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioState = context.watch<AudioProvider>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Slider(
                max: 0.05,
                label: (audioState.volume * 1000 * 2).round().toString(),
                divisions: 5,
                value: audioState.volume,
                onChanged: (double _) =>
                    context.read<AudioProvider>().onVolumeChange(_)),
            Text('${audioState.volume}'),
            const SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                    value: audioState.playerState == PlayerState.paused,
                    onChanged: (_) {
                      if (audioState.playerState == PlayerState.playing) {
                        context.read<AudioProvider>().onPauseAudio();
                      } else {
                        context.read<AudioProvider>().onResumeAudio();
                      }
                    }),
                const Text('BGM')
              ],
            )
          ],
        ),
      ),
    );
  }
}

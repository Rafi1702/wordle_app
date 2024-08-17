import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tebak_kata/global_state/settings_provider.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioState = context.watch<SettingsProvider>();
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Music', style: Theme.of(context).textTheme.labelLarge),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                overlayShape: SliderComponentShape.noOverlay,
              ),
              child: Slider(
                  max: 0.05,
                  value: audioState.volume,
                  onChanged: (double _) =>
                      context.read<SettingsProvider>().onVolumeChange(_)),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Checkbox(
                    value: audioState.isBgmActive,
                    onChanged: (_) {
                      context.read<SettingsProvider>().onBgmCheckBoxTap();
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

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:tebak_kata/providers/audio_provider.dart';

class AudioPage extends StatelessWidget {
  final double volume;
  final void Function(double)? onVolumeChanged;
  const AudioPage(
      {super.key, required this.volume, required this.onVolumeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Slider(
                max: 1.0,
                label: volume.toString(),
                divisions: 5,
                value: volume,
                onChanged: onVolumeChanged,
              ),
              Text('${volume}'),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

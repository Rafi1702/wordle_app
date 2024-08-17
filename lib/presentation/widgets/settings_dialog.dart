import 'dart:math';

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
            Text('Settings', style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            const SizedBox(height: 10.0),
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
            Row(
              children: [
                Checkbox(
                    value: audioState.isBgmActive,
                    onChanged: (_) {
                      context.read<SettingsProvider>().onBgmCheckBoxTap();
                    }),
                const Text('BGM')
              ],
            ),
            const SizedBox(height: 10.0),
            Text('Theme', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10.0),
            Row(
              children: [
                CustomPaint(
                  size: const Size(
                    20.0,
                    20.0,
                  ),
                  painter: DiagonalSplitCirclePainter(
                      circleColor1: Theme.of(context).colorScheme.primary,
                      circleColor2: Theme.of(context).colorScheme.secondary),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DiagonalSplitCirclePainter extends CustomPainter {
  final Color circleColor1;
  final Color circleColor2;
  DiagonalSplitCirclePainter(
      {required this.circleColor1, required this.circleColor2});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintLeft = Paint()
      ..color = circleColor1 // Warna bagian kiri
      ..style = PaintingStyle.fill;

    final Paint paintRight = Paint()
      ..color = circleColor2 // Warna bagian kanan
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    final Offset center = size.center(Offset.zero);

    // Menggambar bagian kiri lingkaran
    final Path pathLeft = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        3 * pi / 4,
        //semisal targetnya 315, berarti 315 - 3*pi/4
        pi,
        false,
      )
      ..close();
    canvas.drawPath(pathLeft, paintLeft);

    // Menggambar bagian kanan lingkaran
    final Path pathRight = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(Rect.fromCircle(center: center, radius: radius), 7 * pi / 4, pi,
          false)
      ..close();
    canvas.drawPath(pathRight, paintRight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

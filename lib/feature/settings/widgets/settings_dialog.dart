import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tebak_kata/feature/settings/cubit/settings_cubit.dart';


import 'package:tebak_kata/helper/app_theme.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Column(
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
                      value: state.volume,
                      onChanged: (double _) =>
                          context.read<SettingsCubit>().onVolumeChange(_)),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: state.isBgmMute,
                        onChanged: (_) {
                          context.read<SettingsCubit>().onBgmCheckBoxTap();
                        }),
                    const Text('BGM')
                  ],
                ),
                const SizedBox(height: 10.0),
                Text('Theme', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context
                            .read<SettingsCubit>()
                            .onThemeChange(Themes.sakuraTheme);
                      },
                      child: CustomPaint(
                        size: const Size(
                          20.0,
                          20.0,
                        ),
                        painter: DiagonalSplitCirclePainter(
                            circleColor1:
                                AppTheme.sakuraTheme.colorScheme.primary,
                            circleColor2:
                                AppTheme.sakuraTheme.colorScheme.secondary,
                            isSelected: state.theme == Themes.sakuraTheme),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<SettingsCubit>()
                            .onThemeChange(Themes.blueTheme);
                      },
                      child: CustomPaint(
                        size: const Size(
                          20.0,
                          20.0,
                        ),
                        painter: DiagonalSplitCirclePainter(
                            circleColor1:
                                AppTheme.blueTheme.colorScheme.primary,
                            circleColor2:
                                AppTheme.blueTheme.colorScheme.surface,
                            isSelected: state.theme == Themes.blueTheme),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class DiagonalSplitCirclePainter extends CustomPainter {
  final Color circleColor1;
  final Color circleColor2;
  final bool? isSelected;
  DiagonalSplitCirclePainter(
      {required this.circleColor1,
      required this.circleColor2,
      this.isSelected});
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

    // canvas.drawPath(pathLeft, borderLeft);

    // Menggambar bagian kanan lingkaran
    final Path pathRight = Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(Rect.fromCircle(center: center, radius: radius), 7 * pi / 4, pi,
          false)
      ..close();
    canvas.drawPath(pathRight, paintRight);
    if (isSelected ?? false) {
      final Paint paintBorder = Paint()
        ..color = Colors.green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(center, radius, paintBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

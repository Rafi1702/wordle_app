import 'dart:async';

import 'package:flutter/material.dart';

class LoadingWordleAnimation extends StatefulWidget {
  const LoadingWordleAnimation({super.key});

  @override
  State<LoadingWordleAnimation> createState() => _LoadingAnimationState();
}

class _LoadingAnimationState extends State<LoadingWordleAnimation> {
  List<List<int>> indicators = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
  ];
  int test = 0;
  final _column = 4;
  final _row = 4;

  int _currentColumn = 0;
  late Timer timer;
  Future<void> updateIndicators() async {
    setState(() {});
    for (int i = 0; i < indicators.length; i++) {
      await Future.delayed(const Duration(milliseconds: 900));
      for (int j = 0; j <= i; j++) {
        if (i == j) {
          indicators[i][j] = 1;
        } else {
          indicators[i][j] = -1;
        }
      }
      _currentColumn += 1;
    }
    if (_currentColumn == _column) {
      indicators = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
      ];
      _currentColumn = 0;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // incrementGreenIndicatorIndex();
    timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) async {
        await updateIndicators();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: _row,
            separatorBuilder: (context, rowIndex) => const SizedBox(
                  height: 10.0,
                ),
            itemBuilder: (context, rowIndex) {
              return Center(
                child: Wrap(
                  spacing: 10.0,
                  children: List.generate(
                    _column,
                    (columnIndex) {
                      return Container(
                        height: 20.0,
                        width: 20.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: indicators[rowIndex][columnIndex] == 1
                              ? Colors.green
                              : indicators[rowIndex][columnIndex] < 0
                                  ? Colors.yellow
                                  : Theme.of(context).colorScheme.onSurface,
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}

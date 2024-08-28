import 'package:flutter/material.dart';
import 'package:tebak_kata/feature/wordle/presentation/wordle_page.dart';

class HomePage extends StatelessWidget {
  static const route = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                style: const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size(
                  200.0,
                  60.0,
                ))),
                onPressed: () {
                  Navigator.of(context).pushNamed(WordlePage.route);
                },
                icon: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 40.0,
                ),
                label: Text(
                  'Main',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

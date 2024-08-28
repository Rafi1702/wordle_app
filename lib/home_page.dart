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
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(WordlePage.route);
                  },
                  icon: Icon(Icons.play_arrow_rounded,
                      color: Theme.of(context).colorScheme.onPrimary),
                  label: const Text('Main'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

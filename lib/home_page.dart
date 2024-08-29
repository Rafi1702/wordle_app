import 'package:flutter/material.dart';
import 'package:tebak_kata/feature/settings/widgets/settings_dialog.dart';
import 'package:tebak_kata/feature/wordle/presentation/wordle_page.dart';

class HomePage extends StatelessWidget {
  static const route = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    Navigator.of(context).pushNamed(WordlePage.route);
                  },
                  child: Container(
                      width: 300.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Theme.of(context).colorScheme.primary),
                      child: Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 2,
                            child: Text('Play',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(fontWeight: FontWeight.w900)),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                  )),
                              height: 50.0,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('4-5',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                  const Text('Letters'),
                                ],
                              )),
                            ),
                          )
                        ],
                      )),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            CircleBorder(),
                          ),
                        ),
                        child: const Icon(Icons.question_mark_rounded),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog<double>(
                            context: context,
                            builder: (BuildContext context) =>
                                const CustomDialog(),
                          );
                        },
                        style: const ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            CircleBorder(),
                          ),
                        ),
                        child: const Icon(Icons.settings),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

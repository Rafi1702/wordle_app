import 'package:flutter/material.dart';
import 'package:tebak_kata/feature/settings/widgets/settings_dialog.dart';
import 'package:tebak_kata/feature/wordle/presentation/wordle_page.dart';
import 'package:tebak_kata/feature/wordle/widget/letter_card.dart';

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
                    Navigator.of(context).pushNamed(WordlePage2.route);
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
                                    .copyWith(
                                        fontWeight: FontWeight.w900,
                                        color: Colors.black)),
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
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                const _HelpDialog(),
                          );
                        },
                        style: const ButtonStyle(
                          shape: WidgetStatePropertyAll(
                            CircleBorder(),
                          ),
                        ),
                        child: const Icon(Icons.question_mark_rounded),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                const SettingsDialog(),
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

class _HelpDialog extends StatelessWidget {
  const _HelpDialog();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Help',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            const Divider(
              thickness: 1.5,
            ),
            const _HelpPoint(
              number: '1',
              explanationPoint: 'Guess the Word: ',
              explanation:
                  'goal is to guess a hidden 5-letter word within 6 attempts.',
            ),
            const SizedBox(height: 8.0),
            const _HelpPoint(
              number: '2',
              explanationPoint: 'Enter a Word: ',
              explanation: 'Type a valid 5-letter word and press "Enter".',
            ),
            const SizedBox(height: 8.0),
            const Column(
              children: [
                _HelpPoint(
                  number: '3',
                  explanationPoint: 'Get Feedback: ',
                  explanation: '',
                ),
                Row(
                  children: [
                    LetterCard(
                      letter: 'P',
                    ),
                    LetterCard(
                      letter: 'A',
                      color: Colors.green,
                    ),
                    LetterCard(
                      letter: 'I',
                    ),
                    LetterCard(
                      letter: 'N',
                    ),
                  ],
                ),
                Text('Green: The letter is correct and in the right position.'),
                Row(
                  children: [
                    LetterCard(
                      letter: 'S',
                    ),
                    LetterCard(
                      letter: 'H',
                    ),
                    LetterCard(
                      letter: 'O',
                      color: Colors.yellow,
                    ),
                    LetterCard(
                      letter: 'W',
                    ),
                  ],
                ),
                Text(
                    'Yellow: The letter is in the word but in the wrong position.'),
                Row(
                  children: [
                    LetterCard(
                      letter: 'R',
                    ),
                    LetterCard(
                      letter: 'A',
                    ),
                    LetterCard(
                      letter: 'I',
                    ),
                    LetterCard(
                      letter: 'N',
                    ),
                  ],
                ),
                Text('Gray: The letter is not in the word at all.')
              ],
            ),
            const SizedBox(height: 8.0),
            const _HelpPoint(
              number: '4',
              explanationPoint: 'Guess the Word: ',
              explanation:
                  'goal is to guess a hidden 5-letter word within 6 attempts.',
            ),
            const SizedBox(height: 8.0),
            const _HelpPoint(
              number: '5',
              explanationPoint: 'Win or Lose: ',
              explanation:
                  'If you guess the word correctly within 6 tries, you win! If not, the correct word will be revealed.',
            )
          ],
        ),
      ),
    );
  }
}

class _HelpPoint extends StatelessWidget {
  final String number;
  final String explanationPoint;
  final String explanation;
  const _HelpPoint({
    required this.number,
    required this.explanationPoint,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$number. '),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: explanationPoint,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.w800),
                ),
                TextSpan(text: explanation),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

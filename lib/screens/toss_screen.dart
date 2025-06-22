import 'package:flutter/material.dart';
import 'dart:math';
import '../models/game_settings.dart';
import 'game_screen.dart';

class TossScreen extends StatefulWidget {
  const TossScreen({Key? key}) : super(key: key);

  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  TossChoice? _userChoice;
  TossChoice? _tossResult;
  bool _tossDone = false;
  bool _userWonToss = false;
  PlayChoice? _userPlayChoice;
  bool _playChoiceDone = false;

  void _doToss(TossChoice choice) {
    setState(() {
      _userChoice = choice;
      _tossResult = Random().nextBool() ? TossChoice.head : TossChoice.tail;
      _tossDone = true;
      _userWonToss = _userChoice == _tossResult;
    });
  }

  void _choosePlay(PlayChoice playChoice) {
    setState(() {
      _userPlayChoice = playChoice;
      _playChoiceDone = true;
    });
    // TODO: Navigate to GameScreen with settings
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toss')), 
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: !_tossDone
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Choose Head or Tail',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _doToss(TossChoice.head),
                          child: const Text('Head'),
                        ),
                        const SizedBox(width: 32),
                        ElevatedButton(
                          onPressed: () => _doToss(TossChoice.tail),
                          child: const Text('Tail'),
                        ),
                      ],
                    ),
                  ],
                )
              : !_playChoiceDone
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Toss Result: ${_tossResult == TossChoice.head ? 'Head' : 'Tail'}',
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _userWonToss
                              ? 'You won the toss! Choose to Bat or Bowl.'
                              : 'Computer won the toss!',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32),
                        _userWonToss
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _choosePlay(PlayChoice.bat),
                                    child: const Text('Bat'),
                                  ),
                                  const SizedBox(width: 32),
                                  ElevatedButton(
                                    onPressed: () => _choosePlay(PlayChoice.bowl),
                                    child: const Text('Bowl'),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    'Computer chooses to ${Random().nextBool() ? 'Bat' : 'Bowl'}',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 24),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _playChoiceDone = true;
                                      });
                                      Future.delayed(const Duration(milliseconds: 500), () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const GameScreen()),
                                        );
                                      });
                                    },
                                    child: const Text('Continue'),
                                  ),
                                ],
                              ),
                      ],
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Ready for the match!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const GameScreen()),
                            );
                          },
                          child: const Text('Start Match'),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String result;
  final int runs;
  final int wickets;
  final int overs;

  const ResultScreen({
    Key? key,
    required this.result,
    required this.runs,
    required this.wickets,
    required this.overs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Result')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              result,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Text('Runs: $runs', style: const TextStyle(fontSize: 22)),
            Text('Wickets: $wickets', style: const TextStyle(fontSize: 22)),
            Text('Overs: $overs', style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
} 
import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../core/constants.dart';
import '../models/game_settings.dart';
import 'toss_screen.dart';
import 'stats_screen.dart';
import 'team_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedOvers = GameConstants.oversOptions.first;
  MatchType _selectedMatchType = MatchType.single;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hand Cricket'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Text(
                'Welcome to Hand Cricket!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 32),
              Text('Select Overs:', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: GameConstants.oversOptions.map((overs) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text('$overs'),
                      selected: _selectedOvers == overs,
                      onSelected: (_) {
                        setState(() {
                          _selectedOvers = overs;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              Text('Match Type:', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text('Single Match'),
                    selected: _selectedMatchType == MatchType.single,
                    onSelected: (_) {
                      setState(() {
                        _selectedMatchType = MatchType.single;
                      });
                    },
                  ),
                  const SizedBox(width: 16),
                  ChoiceChip(
                    label: const Text('Tournament'),
                    selected: _selectedMatchType == MatchType.tournament,
                    onSelected: (_) {
                      setState(() {
                        _selectedMatchType = MatchType.tournament;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.sports_cricket),
                label: const Text('Start Match'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TossScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                icon: const Icon(Icons.bar_chart),
                label: const Text('View Stats'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StatsScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
              const SizedBox(height: 20),
              OutlinedButton.icon(
                icon: const Icon(Icons.group),
                label: const Text('Team Profile'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TeamProfileScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
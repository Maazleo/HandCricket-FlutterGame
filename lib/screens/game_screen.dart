import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'dart:math';
import 'team_profile_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int over = 1;
  int ball = 1;
  int runs = 0;
  int wickets = 0;
  int userChoice = -1;
  int computerChoice = -1;
  String message = 'Your turn!';
  bool isUserBatting = true;
  bool matchEnded = false;

  // Two innings support
  int currentInnings = 1; // 1 or 2
  int firstInningsRuns = 0;
  int firstInningsWickets = 0;
  int target = 0;
  bool chasing = false;

  // Celebration state
  String? celebration;
  int consecutiveWickets = 0;
  int batterRuns = 0;
  int teamFiftyCelebrated = 0;
  int teamHundredCelebrated = 0;
  int batterFiftyCelebrated = 0;

  // Scoreboard and player stats
  String userTeamName = 'User XI';
  List<String> userBatters = ['Babloo', 'Guddu', 'Chintu', 'Pappu', 'Munna', 'Tinku', 'Sonu', 'Raju', 'Bunty', 'Golu', 'Mithu'];
  List<String> userRoles = List.generate(11, (i) => 'Batter');
  int userCaptain = 0;
  int userWicketKeeper = 0;
  List<String> computerBatters = ['AI-Bat1', 'AI-Bat2', 'AI-Bat3', 'AI-Bat4', 'AI-Bat5', 'AI-Bat6', 'AI-Bat7', 'AI-Bat8', 'AI-Bat9', 'AI-Bat10', 'AI-Bat11'];
  List<String> bowlers = ['Babloo', 'Guddu', 'Chintu', 'Pappu', 'Munna'];
  int strikerIndex = 0;
  int nonStrikerIndex = 1;
  int bowlerIndex = 0;
  List<Map<String, int>> batterStats = List.generate(11, (_) => {'runs': 0, 'balls': 0});
  int bowlerRuns = 0;
  List<int> overBalls = [];

  @override
  void initState() {
    super.initState();
    _loadTeamProfile();
  }

  Future<void> _loadTeamProfile() async {
    final profile = await loadTeamProfile();
    if (profile != null) {
      setState(() {
        userTeamName = profile['teamName'] ?? userTeamName;
        userBatters = List<String>.from(profile['playerNames'] ?? userBatters);
        userRoles = List<String>.from(profile['roles'] ?? userRoles);
        userCaptain = profile['captainIndex'] ?? 0;
        userWicketKeeper = profile['wicketKeeperIndex'] ?? 0;
        // Use only non-empty names
        userBatters = userBatters.where((name) => name.trim().isNotEmpty).toList();
        if (userBatters.length < 11) {
          userBatters = [...userBatters, ...List.generate(11 - userBatters.length, (i) => 'Player${i + 1}')];
        }
      });
    }
  }

  void _playBall(int choice) {
    setState(() {
      celebration = null;
      userChoice = choice;
      computerChoice = (List.generate(7, (i) => i)..shuffle()).first;
      bool wicket = false;
      int shot = isUserBatting ? userChoice : computerChoice;
      int batterIdx = strikerIndex;
      if (userChoice == computerChoice) {
        wickets++;
        consecutiveWickets++;
        batterRuns = 0;
        wicket = true;
        if (consecutiveWickets == 3) {
          celebration = '🎩 Hat-trick!';
        } else {
          celebration = '💥 Wicket!';
        }
        message = 'Wicket!';
        // Next batter comes in
        if (wickets < 10) {
          strikerIndex = max(strikerIndex, nonStrikerIndex) + 1;
          batterStats[strikerIndex] = {'runs': 0, 'balls': 0};
        }
      } else {
        consecutiveWickets = 0;
        runs += shot;
        batterRuns += shot;
        batterStats[batterIdx]['runs'] = (batterStats[batterIdx]['runs'] ?? 0) + shot;
        batterStats[batterIdx]['balls'] = (batterStats[batterIdx]['balls'] ?? 0) + 1;
        bowlerRuns += shot;
        overBalls.add(shot);
        if (shot == 4) {
          celebration = '🏏 Four!';
        } else if (shot == 6) {
          celebration = '🎉 Six!';
        }
        if (batterRuns >= 50 && batterFiftyCelebrated < currentInnings) {
          celebration = '🔥 50 runs by batter!';
          batterFiftyCelebrated = currentInnings;
        }
        if (runs >= 50 && teamFiftyCelebrated < currentInnings) {
          celebration = '🎊 Team 50!';
          teamFiftyCelebrated = currentInnings;
        }
        if (runs >= 100 && teamHundredCelebrated < currentInnings) {
          celebration = '🏆 Team 100!';
          teamHundredCelebrated = currentInnings;
        }
        message = isUserBatting ? 'You scored $userChoice!' : 'Computer scored $computerChoice!';
        // Rotate strike on 1, 3, 5
        if ([1, 3, 5].contains(shot)) {
          int temp = strikerIndex;
          strikerIndex = nonStrikerIndex;
          nonStrikerIndex = temp;
        }
      }
      if (ball == 6) {
        over++;
        ball = 1;
        bowlerIndex = (bowlerIndex + 1) % bowlers.length;
        bowlerRuns = 0;
        overBalls.clear();
        // Swap striker/non-striker
        int temp = strikerIndex;
        strikerIndex = nonStrikerIndex;
        nonStrikerIndex = temp;
      } else {
        ball++;
      }
      // End of innings
      if (wickets == 10 || over > 5) {
        if (currentInnings == 1) {
          // Save first innings score and switch roles
          firstInningsRuns = runs;
          firstInningsWickets = wickets;
          target = runs + 1;
          runs = 0;
          wickets = 0;
          over = 1;
          ball = 1;
          isUserBatting = !isUserBatting;
          currentInnings = 2;
          chasing = true;
          batterRuns = 0;
          strikerIndex = 0;
          nonStrikerIndex = 1;
          bowlerIndex = 0;
          bowlerRuns = 0;
          overBalls.clear();
          batterStats = List.generate(11, (_) => {'runs': 0, 'balls': 0});
          message = isUserBatting
              ? 'Your turn to chase! Target: $target'
              : 'Computer is chasing! Target: $target';
        } else {
          // End of match
          matchEnded = true;
          if (runs >= target) {
            message = isUserBatting ? 'You Won!' : 'Computer Won!';
          } else if ((wickets == 10 || over > 5) && runs < target - 1) {
            message = isUserBatting ? 'You Lost!' : 'Computer Lost!';
          } else if (runs == target - 1) {
            message = 'Match Tied!';
          }
        }
      } else if (chasing && runs >= target) {
        matchEnded = true;
        message = isUserBatting ? 'You Won!' : 'Computer Won!';
      }
    });
  }

  void _showResult() {
    String result;
    if (runs >= target) {
      result = isUserBatting ? 'You Won!' : 'Computer Won!';
    } else if (runs == target - 1) {
      result = 'Match Tied!';
    } else {
      result = isUserBatting ? 'You Lost!' : 'Computer Lost!';
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          result: result,
          runs: runs,
          wickets: wickets,
          overs: over,
        ),
      ),
    );
  }

  double get runRate => over > 1 || ball > 1 ? runs / (((over - 1) * 6 + (ball - 1)).clamp(1, 100)) * 6 : 0;

  @override
  Widget build(BuildContext context) {
    String batting = isUserBatting ? userTeamName : 'Computer XI';
    String bowling = isUserBatting ? 'Computer XI' : userTeamName;
    String chaseText = '';
    if (chasing) {
      chaseText = isUserBatting ? 'You are chasing $target' : 'Computer is chasing $target';
    }
    String striker = isUserBatting ? userBatters[strikerIndex] : computerBatters[strikerIndex];
    String nonStriker = isUserBatting ? userBatters[nonStrikerIndex] : computerBatters[nonStrikerIndex];
    String bowler = bowlers[bowlerIndex];
    int strikerRuns = batterStats[strikerIndex]['runs'] ?? 0;
    int strikerBalls = batterStats[strikerIndex]['balls'] ?? 0;
    int nonStrikerRuns = batterStats[nonStrikerIndex]['runs'] ?? 0;
    int nonStrikerBalls = batterStats[nonStrikerIndex]['balls'] ?? 0;
    double strikerSR = strikerBalls > 0 ? (strikerRuns / strikerBalls) * 100 : 0;
    return Scaffold(
      appBar: AppBar(title: const Text('Hand Cricket')),
      body: Stack(
        children: [
          Container(
            color: Colors.green.shade200,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TV-style Scoreboard
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Score: $runs/$wickets',
                            style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Overs: $over.${ball - 1}',
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            'RR: ${runRate.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      if (chasing)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Target: $target',
                            style: const TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold),
                          ),
                        ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Text('This Over:', style: TextStyle(color: Colors.white70)),
                          const SizedBox(width: 8),
                          ...overBalls.map((r) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('$r', style: const TextStyle(fontWeight: FontWeight.bold)),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text('Innings: $currentInnings', style: const TextStyle(fontSize: 18)),
                Text('Batting: $batting', style: const TextStyle(fontSize: 16)),
                Text('Bowling: $bowling', style: const TextStyle(fontSize: 16)),
                if (chasing)
                  Text(chaseText, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                if (celebration != null)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child: Text(
                      celebration!,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ),
                Text(message, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 16),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: !matchEnded
                        ? Wrap(
                            spacing: 16,
                            children: List.generate(7, (i) => i).map((num) => ElevatedButton(
                              onPressed: () => _playBall(num),
                              child: Text('$num', style: const TextStyle(fontSize: 24)),
                            )).toList(),
                          )
                        : ElevatedButton(
                            onPressed: _showResult,
                            child: const Text('Show Result'),
                          ),
                  ),
                ),
                // Bottom Scorecard
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Striker: $striker', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text('Runs: $strikerRuns  Balls: $strikerBalls  SR: ${strikerSR.toStringAsFixed(1)}', style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Non-Striker: $nonStriker', style: const TextStyle(color: Colors.white)),
                          Text('Runs: $nonStrikerRuns  Balls: $nonStrikerBalls', style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Bowler: $bowler', style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
                          Text('Runs this over: $bowlerRuns', style: const TextStyle(color: Colors.amberAccent)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 
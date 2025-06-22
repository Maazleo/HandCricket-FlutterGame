import 'player.dart';
import 'score.dart';
import 'game_settings.dart';

enum MatchStatus { notStarted, inProgress, completed }

class HandCricketMatch {
  final Player user;
  final Player computer;
  Score userScore;
  Score computerScore;
  int currentOver;
  int currentBall;
  int wicketsLeft;
  MatchStatus status;
  final GameSettings settings;

  HandCricketMatch({
    required this.user,
    required this.computer,
    required this.userScore,
    required this.computerScore,
    required this.currentOver,
    required this.currentBall,
    required this.wicketsLeft,
    required this.status,
    required this.settings,
  });

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'computer': computer.toJson(),
        'userScore': userScore.toJson(),
        'computerScore': computerScore.toJson(),
        'currentOver': currentOver,
        'currentBall': currentBall,
        'wicketsLeft': wicketsLeft,
        'status': status.index,
        'settings': settings.toJson(),
      };

  factory HandCricketMatch.fromJson(Map<String, dynamic> json) => HandCricketMatch(
        user: Player.fromJson(json['user']),
        computer: Player.fromJson(json['computer']),
        userScore: Score.fromJson(json['userScore']),
        computerScore: Score.fromJson(json['computerScore']),
        currentOver: json['currentOver'],
        currentBall: json['currentBall'],
        wicketsLeft: json['wicketsLeft'],
        status: MatchStatus.values[json['status']],
        settings: GameSettings.fromJson(json['settings']),
      );
} 
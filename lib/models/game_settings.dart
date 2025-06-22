enum MatchType { single, tournament }

enum TossChoice { head, tail }

enum PlayChoice { bat, bowl }

class GameSettings {
  final int overs;
  final MatchType matchType;
  final TossChoice tossChoice;
  final PlayChoice playChoice;

  GameSettings({
    required this.overs,
    required this.matchType,
    required this.tossChoice,
    required this.playChoice,
  });

  Map<String, dynamic> toJson() => {
        'overs': overs,
        'matchType': matchType.index,
        'tossChoice': tossChoice.index,
        'playChoice': playChoice.index,
      };

  factory GameSettings.fromJson(Map<String, dynamic> json) => GameSettings(
        overs: json['overs'],
        matchType: MatchType.values[json['matchType']],
        tossChoice: TossChoice.values[json['tossChoice']],
        playChoice: PlayChoice.values[json['playChoice']],
      );
} 
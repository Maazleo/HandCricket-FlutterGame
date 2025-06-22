class Player {
  final String name;
  final bool isUser;
  int runs;
  int wickets;
  int balls;
  final String avatar;

  Player({
    required this.name,
    required this.isUser,
    this.runs = 0,
    this.wickets = 0,
    this.balls = 0,
    required this.avatar,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'isUser': isUser,
        'runs': runs,
        'wickets': wickets,
        'balls': balls,
        'avatar': avatar,
      };

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        name: json['name'],
        isUser: json['isUser'],
        runs: json['runs'],
        wickets: json['wickets'],
        balls: json['balls'],
        avatar: json['avatar'],
      );
} 
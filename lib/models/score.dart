class Score {
  int runs;
  int wickets;
  int balls;
  int overs;

  Score({
    this.runs = 0,
    this.wickets = 0,
    this.balls = 0,
    this.overs = 0,
  });

  Map<String, dynamic> toJson() => {
        'runs': runs,
        'wickets': wickets,
        'balls': balls,
        'overs': overs,
      };

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        runs: json['runs'],
        wickets: json['wickets'],
        balls: json['balls'],
        overs: json['overs'],
      );
} 
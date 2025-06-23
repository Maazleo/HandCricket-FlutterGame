// Tournament data models for Hand Cricket Game

class Team {
  final String name;
  final bool isUserTeam;

  Team({required this.name, this.isUserTeam = false});
}

enum MatchResult { notPlayed, team1Win, team2Win, tie }

class Match {
  final Team team1;
  final Team team2;
  MatchResult result;
  int? team1Score;
  int? team2Score;

  Match({required this.team1, required this.team2, this.result = MatchResult.notPlayed});
}

class Group {
  final String name;
  final List<Team> teams;
  final List<Match> matches;

  Group({required this.name, required this.teams, required this.matches});
}

class PointsTableEntry {
  final Team team;
  int played = 0;
  int won = 0;
  int lost = 0;
  int tied = 0;
  int points = 0;
  int runsFor = 0;
  int runsAgainst = 0;

  PointsTableEntry({required this.team});
}

enum TournamentStage { group, super4, finalMatch, completed }

class Tournament {
  List<Group> groups;
  List<Team> super4Teams;
  List<Match> super4Matches;
  Match? finalMatch;
  TournamentStage stage;

  Tournament({
    required this.groups,
    this.super4Teams = const [],
    this.super4Matches = const [],
    this.finalMatch,
    this.stage = TournamentStage.group,
  });
} 
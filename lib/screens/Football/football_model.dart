class FootballModel {
  final String name;
  final String badge;
  final String stadium;
  final String location;

  FootballModel({
    required this.name,
    required this.badge,
    required this.stadium,
    required this.location,
  });

  factory FootballModel.fromJson(Map<String, dynamic> json) {
    return FootballModel(
      name: json['strTeam'] ?? 'Unknown Team',
      badge: json['strBadge'] ?? 'No Badge',
      stadium: json['strStadium'] ?? 'Unknown Stadium',
      location: json['strLocation'] ?? 'Unknown Location',
    );
  }
}
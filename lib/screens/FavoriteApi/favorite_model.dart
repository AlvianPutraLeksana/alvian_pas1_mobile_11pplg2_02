class FavoriteAnime {
  final String name ;
  final String badge;
  final String stadium;
  final String location;

  FavoriteAnime({
    required this.name,
    required this.badge,
    required this.stadium,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'badge': badge,
      'stadium': stadium,
      'location': location,
    };
  }

  factory FavoriteAnime.fromMap(Map<String, dynamic> map) {
    return FavoriteAnime(
      name: map['name'],
      badge: map['badge'],
      stadium: map['stadium'],
      location: map['location'],
    );
  }
} 
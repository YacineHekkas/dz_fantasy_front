import 'player.dart';

class Club {
  final String clubName;
  final List<Player> players;

  Club({
    required this.clubName,
    required this.players,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    if (json['clubName'] == null) {
      throw FormatException('Club name is missing');
    }
    if (json['players'] == null) {
      throw FormatException('Players list is missing');
    }
    return Club(
      clubName: json['clubName'] as String,
      players: (json['players'] as List<dynamic>)
          .map((playerJson) => Player.fromJson(playerJson))
          .where((player) => player != null)
          .cast<Player>()
          .toList(),
    );
  }
}
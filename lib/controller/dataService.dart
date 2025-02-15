import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/club.dart';
import '../model/player.dart';

class DataService {
  static final DataService _instance = DataService._internal();

  factory DataService() {
    return _instance;
  }

  DataService._internal() {
    fetchPlayers();
    _initializeData();
  }

  List<Club> _clubs = [];
  List<Player> _allPlayers = [];
  bool _isDataLoaded = false;
  bool _isClubsLoaded = false;

  void _initializeData() {
    // Keep the existing static data initialization
    // ... (keep all the existing static data)

    _isDataLoaded = true;
    print('Static data loaded successfully. Total clubs: ${_clubs.length}, Total players: ${_allPlayers.length}');
  }
  Future<List<Player>?> fetchPlayers({String? position}) async {
    try {
      // Hardcoded token
      final headers = {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImlhdCI6MTczOTU4MDY3MywiZXhwIjoxNzM5NjY3MDczfQ.wbW5jLsid4yN1FSMjIHezrhVUDXiWuOrzLvzcBD9XXI',
      };

      // Make the GET request with headers
      final response = await http.get(
        Uri.parse('https://fantasy-0ek6.onrender.com/api/players'),
        headers: headers,
      );

      print(response.body);

      if (response.statusCode == 200) {
        // Decode the JSON response
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Extract the `players` list
        final List<dynamic> playerData = jsonResponse['players'];

        // Map the JSON objects to Player objects
        List<Player> apiPlayers = playerData
            .map((playerJson) => Player.fromJson(playerJson as Map<String, dynamic>))
            .toList();

        // If position is provided, filter players by position
        if (position != null) {
          apiPlayers = apiPlayers.where((player) => player.position == position).toList();
        }

        // Merge API players with existing static players
        _allPlayers = [..._allPlayers, ...apiPlayers];
        _isDataLoaded = true;

        print('API Players loaded successfully. Total players: ${_allPlayers.length}');
        print(_allPlayers[0].logoUrl);
        return _allPlayers;
      } else {
        print('Failed to load players: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching players: $e');
      return null;
    }
  }




  Future<int?> fetchTeamPoints({required int userId, required int gameWeek}) async {
    try {
      final url = Uri.parse('https://fantasy-0ek6.onrender.com/api/landing');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'gameWeek': gameWeek,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final int teamPoints = jsonResponse['points'];
        print('Team points for user $userId in game week $gameWeek: $teamPoints');
        return teamPoints;
      } else {
        print('Failed to fetch team points: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching team points: $e');
      return null;
    }
  }
  Future<bool> startGameWeek() async {
    try {
      // Hardcoded token
      final headers = {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOjEsImlhdCI6MTczOTU4MDY3MywiZXhwIjoxNzM5NjY3MDczfQ.wbW5jLsid4yN1FSMjIHezrhVUDXiWuOrzLvzcBD9XXI',
        'Content-Type': 'application/json',
      };

      // API endpoint
      final url = Uri.parse('https://fantasy-0ek6.onrender.com/api/gameweek/start');

      // Make the POST request
      final response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        print('Game week started successfully.');
        return true;
      } else {
        print('Failed to start game week: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error starting game week: $e');
      return false;
    }
  }

  List<Player> getPlayersByPosition(String position) {
    if (!_isDataLoaded) {
      print('Data not loaded yet');
      return [];
    }
    return _allPlayers.where((player) => player.position == position).toList();
  }

  List<Club> getClubs() {
    return _clubs;
  }

  List<Player> getAllPlayers() {
    return _allPlayers;
  }
}



import '../model/club.dart';
import '../model/player.dart';

class DataService {
  static final DataService _instance = DataService._internal();

  factory DataService() {
    return _instance;
  }

  DataService._internal() {
    _initializeData();
  }

  List<Club> _clubs = [];
  List<Player> _allPlayers = [];
  bool _isDataLoaded = false;

  void _initializeData() {
    _clubs = [
      Club(
        clubName: 'CR Belouizdad',
        players: [
          Player(
            name: 'Alexis Guendouz',
            position: 'GKP',
            clubName: 'CR Belouizdad',
            price: 5.5,
            kitImageUrl: 'assets/clubs/crb_kit.png',
            form: '7.2',
          ),
          Player(
            name: 'Chouaib Keddad',
            position: 'DEF',
            clubName: 'CR Belouizdad',
            price: 6.0,
            kitImageUrl: 'assets/clubs/crb_kit.png',
            form: '6.8',
          ),
          Player(
            name: 'Zakaria Draoui',
            position: 'MID',
            clubName: 'CR Belouizdad',
            price: 7.5,
            kitImageUrl: 'assets/clubs/crb_kit.png',
            form: '8.1',
          ),
          Player(
            name: 'Islam Belkhir',
            position: 'FWD',
            clubName: 'CR Belouizdad',
            price: 9.0,
            kitImageUrl: 'assets/clubs/crb_kit.png',
            form: '7.9',
          ),
        ],
      ),
      Club(
        clubName: 'ES Sétif',
        players: [
          Player(
            name: 'Sofiane Khedairia',
            position: 'GKP',
            clubName: 'ES Sétif',
            price: 5.0,
            kitImageUrl: 'assets/clubs/ess_kit.png',
            form: '6.5',
          ),
          Player(
            name: 'Houcine Benayada',
            position: 'DEF',
            clubName: 'ES Sétif',
            price: 5.5,
            kitImageUrl: 'assets/clubs/ess_kit.png',
            form: '7.0',
          ),
          Player(
            name: 'Amir Karaoui',
            position: 'MID',
            clubName: 'ES Sétif',
            price: 6.5,
            kitImageUrl: 'assets/clubs/ess_kit.png',
            form: '7.3',
          ),
          Player(
            name: 'Mohamed Amine Amoura',
            position: 'FWD',
            clubName: 'ES Sétif',
            price: 8.0,
            kitImageUrl: 'assets/clubs/ess_kit.png',
            form: '8.2',
          ),
        ],
      ),
      Club(
        clubName: 'JS Kabylie',
        players: [
          Player(
            name: 'Oussama Benbot',
            position: 'GKP',
            clubName: 'JS Kabylie',
            price: 4.5,
            kitImageUrl: 'assets/clubs/jsk_kit.png',
            form: '6.7',
          ),
          Player(
            name: 'Badreddine Souyad',
            position: 'DEF',
            clubName: 'JS Kabylie',
            price: 5.0,
            kitImageUrl: 'assets/clubs/jsk_kit.png',
            form: '6.9',
          ),
          Player(
            name: 'Malik Raiah',
            position: 'MID',
            clubName: 'JS Kabylie',
            price: 6.0,
            kitImageUrl: 'assets/clubs/jsk_kit.png',
            form: '7.1',
          ),
          Player(
            name: 'Redha Bensayah',
            position: 'FWD',
            clubName: 'JS Kabylie',
            price: 7.5,
            kitImageUrl: 'assets/clubs/jsk_kit.png',
            form: '7.6',
          ),
        ],
      ),
    ];

    _allPlayers = _clubs.expand((club) => club.players).toList();
    _isDataLoaded = true;
    print('Data loaded successfully. Total clubs: ${_clubs.length}, Total players: ${_allPlayers.length}');
  }

  List<Player> getPlayersByPosition(String position) {
    if (!_isDataLoaded) {
      print('Data not loaded yet');
      return [];
    }
    return _allPlayers.where((player) => player.position == position).toList();
  }

  List<Player> filterPlayers({
    String? position,
    String? club,
    double? maxPrice,
    String? searchQuery,
  }) {

    if (!_isDataLoaded) {
      print('Data not loaded yet');
      return [];
    }
    return _allPlayers.where((player) {
      if (position != null && player.position != position) return false;
      if (club != null && club != 'All Clubs' && player.clubName != club) {
        return false;
      }
      if (maxPrice != null && player.price > maxPrice) return false;
      if (searchQuery != null && searchQuery.isNotEmpty) {
        return player.name.toLowerCase().contains(searchQuery.toLowerCase());
      }
      return true;
    }).toList();
  }

  List<String> getAllClubs() {
    return ['All Clubs'] + _clubs.map((club) => club.clubName).toList();
  }
}
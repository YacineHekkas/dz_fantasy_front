import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../model/player.dart';

class TeamDetailsScreen extends StatefulWidget {
  const TeamDetailsScreen({super.key});

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  Map<String, Player?> teamPlayers = {};
  String selectedTab = "Squad"; // "Squad" or "List"

  String teamName = '';
  double bank = 0.0;
  String selectedFormation = '4-4-2';
  Player? selectedPlayer;
  bool isLoading = true;

  final Map<String, List<int>> formations = {
    '4-4-2': [1, 4, 4, 2],
    '4-3-3': [1, 4, 3, 3],
    '3-5-2': [1, 3, 5, 2],
  };

  @override
  void initState() {
    super.initState();
    _loadTeamData();
  }

  Future<void> _loadTeamData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTeam = prefs.getString('savedTeam');
    if (savedTeam != null) {
      final teamData = json.decode(savedTeam);
      print(teamData);
      setState(() {
        teamName = teamData['teamName'];
        bank = teamData['bank'];
        teamPlayers = (teamData['players'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
            key,
            value != null ? Player.fromJson(value) : null,
          ),
        );
        print(teamPlayers['GK1']?.name);
        isLoading = false;
      });
    }
  }

  List<Player> get benchPlayers {
    return [
      teamPlayers['GK2'],
      teamPlayers['DEF5'],
      teamPlayers['MID5'],
      teamPlayers['FWD3'],
    ].whereType<Player>().toList();
  }

  List<Player> get fieldPlayers {
    final formation = formations[selectedFormation]!;
    final players = <Player>[];

    // Add goalkeeper
    if (teamPlayers['GK1'] != null) players.add(teamPlayers['GK1']!);

    // Add defenders
    for (int i = 1; i <= formation[1]; i++) {
      if (teamPlayers['DEF$i'] != null) players.add(teamPlayers['DEF$i']!);
    }

    // Add midfielders
    for (int i = 1; i <= formation[2]; i++) {
      if (teamPlayers['MID$i'] != null) players.add(teamPlayers['MID$i']!);
    }

    // Add forwards
    for (int i = 1; i <= formation[3]; i++) {
      if (teamPlayers['FWD$i'] != null) players.add(teamPlayers['FWD$i']!);
    }

    return players;
  }

  void _swapPlayers(Player player1, Player player2) {
    setState(() {
      String? key1, key2;
      teamPlayers.forEach((key, value) {
        if (value == player1) key1 = key;
        if (value == player2) key2 = key;
      });
      if (key1 != null && key2 != null) {
        final temp = teamPlayers[key1];
        teamPlayers[key1!] = teamPlayers[key2];
        teamPlayers[key2!] = temp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF40E0D0),
              Color(0xFFfffff),
            ],
            stops: [0.0,0.5]
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      'Your Team',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Deadline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Gameweek 25 Deadline: Fri 14 Feb, 19:30',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ),

              // View Toggle
              //TODO ::
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = "Squad";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedTab == "Squad"
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              'Squad',
                              style: TextStyle(
                                color: selectedTab == "Squad"
                                    ? Colors.black
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = "List";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: selectedTab == "List"
                                ? Colors.white
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              'List',
                              style: TextStyle(
                                color: selectedTab == "Squad"
                                    ? Colors.black
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Squad View
              if (selectedTab == "Squad") ...[
                // Formation Selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: formations.keys.map((formation) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedFormation = formation;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedFormation == formation
                            ? const Color(0xFF00FF9D)
                            : Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(formation),
                    );
                  }).toList(),
                ),

                // Pitch (Football Field)
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/stadium.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: formations[selectedFormation]!.asMap().entries.map((entry) {
                        final index = entry.key;
                        final count = entry.value;
                        final startIndex = formations[selectedFormation]!
                            .take(index)
                            .fold(0, (prev, curr) => prev + curr);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            count,
                                (i) => _buildPlayerCard(
                              fieldPlayers[startIndex + i],
                              isField: true,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Bench Players
                Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.grey.withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: benchPlayers
                        .map((player) => _buildPlayerCard(player, isField: false))
                        .toList(),
                  ),
                ),
              ],

              // List View
              if (selectedTab == "List") ...[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Replaced Placeholder with this Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text(
                            '   Player',
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Points    ',
                            style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Display Selected Player (Optional)


                      // List of Players
                      Expanded(
                        child: ListView.builder(
                          itemCount: teamPlayers.length, // Use teamPlayers map length
                          itemBuilder: (context, index) {
                            // Extract keys and use them to get player data
                            String key = teamPlayers.keys.elementAt(index);
                            Player? player = teamPlayers[key];

                            if (player == null) return SizedBox.shrink(); // Handle null case

                            return ListTile(
                              leading: Image.asset(
                                player.kitImageUrl, // Player image
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            title: Text("${player.clubName} • ${player.position}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${player.name}", // Display form points
                                    style: TextStyle(
                                      fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                      "13pt",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  selectedPlayer = key as Player?; // Store key instead of player name
                                });
                              },
                            );
                          },
                        ),
                      )
                      ,
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialButton(String label, IconData icon) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, size: 20),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF00FF9D),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Play',
            style: TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCard(Player player, {required bool isField}) {
    return GestureDetector(
      onTap: () {
        if (selectedPlayer == null) {
          setState(() => selectedPlayer = player);
        } else if (selectedPlayer != player) {
          _swapPlayers(selectedPlayer!, player);
          setState(() => selectedPlayer = null);
        } else {
          setState(() => selectedPlayer = null);
        }
      },
      child: Container(
        width: 60,
        height: 80,
        decoration: BoxDecoration(
          color: selectedPlayer == player
              ? Colors.yellow.withOpacity(0.3)
              : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
          border: selectedPlayer == player
              ? Border.all(color: Colors.yellow, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              player.kitImageUrl,
              height: 40,
              width: 40,
            ),
            Text(
              player.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'LEI (A)',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 8,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
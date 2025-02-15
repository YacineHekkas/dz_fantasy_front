import 'package:dz_fantasy/view/component/actionButton.dart';
import 'package:dz_fantasy/view/screen/selectPlayer_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../model/player.dart';

class CreateTeamScreen extends StatefulWidget {
  final String teamName;

  const CreateTeamScreen({
    super.key,
    required this.teamName,
  });

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  double bank = 100.0;
  Map<String, Player?> selectedPlayers = {
    'GK1': null, 'GK2': null,
    'DEF1': null, 'DEF2': null, 'DEF3': null, 'DEF4': null, 'DEF5': null,
    'MID1': null, 'MID2': null, 'MID3': null, 'MID4': null, 'MID5': null,
    'FWD1': null, 'FWD2': null, 'FWD3': null,
  };

  bool get isTeamComplete => !selectedPlayers.values.contains(null);

  Future<void> saveTeam() async {
    print("done -------------");
    final prefs = await SharedPreferences.getInstance();
    final teamData = {
      'teamName': widget.teamName,
      'bank': bank,
      'players': selectedPlayers.map((key, player) => MapEntry(
        key,
        player?.toJson(),
      )),
    };
    print("not -------------");
    await prefs.setString('savedTeam', jsonEncode(teamData));
    print("done -------------");
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E88E5), // Light Blue
              Color(0xFFFFFFFF), // White
              Color(0xFF4CAF50), // Green
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'create_team'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.purple[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              'team_name'.tr(),
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              widget.teamName,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.purple[900],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Text(
                              'bank'.tr(),
                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              ' DZD ${bank.toStringAsFixed(1)}m',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/stadium.png"),
                        fit: BoxFit.fitWidth
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPlayerSlot('GK1', 'GK'),
                          const SizedBox(width: 25),
                          _buildPlayerSlot('GK2', 'GK'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPlayerSlot('DEF1', 'DF'),
                          _buildPlayerSlot('DEF2', 'DF'),
                          _buildPlayerSlot('DEF3', 'DF'),
                          _buildPlayerSlot('DEF4', 'DF'),
                          _buildPlayerSlot('DEF5', 'DF'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPlayerSlot('MID1', 'MF'),
                          _buildPlayerSlot('MID2', 'MF'),
                          _buildPlayerSlot('MID3', 'MF'),
                          _buildPlayerSlot('MID4', 'MF'),
                          _buildPlayerSlot('MID5', 'MF'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildPlayerSlot('FWD1', 'FW'),
                          _buildPlayerSlot('FWD2', 'FW'),
                          _buildPlayerSlot('FWD3', 'FW'),
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),



              SizedBox(
                width: MediaQuery.sizeOf(context).width*0.7,
                child: ActionButton(
                    text: "Save Team",
                    backgroundColor: Color(0xFF00FF9D),
                    textColor: Colors.black,
                    onPressed: () async {
                      if (isTeamComplete){
                        print("TEST SAVE");
                        await saveTeam();
                        print(" pre TEST SAVE");
                        //TODO :::
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => MainScreen(
                        //     ),
                        //   ),
                        // );
                      }

                    }
                ),

              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerSlot(String slotId, String position) {
    final player = selectedPlayers[slotId];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectPlayerScreen(
              position: position,
              onPlayerSelected: (Player selectedPlayer) {
                setState(() {
                  selectedPlayers[slotId] = selectedPlayer;
                  bank -= selectedPlayer.price;
                });
              },
              bank: bank,
            ),
          ),
        );
      },
      child: Container(
        width: 60,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: player == null
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_outline, color: Colors.white),
            Text(
              position,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Image.asset(
        "assets/${player.logoUrl}",
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
            Text(
              'DZD ${player.price}m',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
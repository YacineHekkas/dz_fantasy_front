import 'dart:convert';
import 'dart:math';

import 'package:dz_fantasy/view/screen/pickTeamName_Screen.dart';
import 'package:dz_fantasy/view/screen/team_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/dataService.dart';
import '../component/actionButton.dart';


class FantasyScreen extends StatefulWidget {
  const FantasyScreen({super.key});

  @override
  State<FantasyScreen> createState() => _FantasyScreenState();
}

class _FantasyScreenState extends State<FantasyScreen> {
  bool decide = false;
  int points = 0;

  @override
  void initState() {
    super.initState();
    _loadSavedTeam(); // Load saved boolean value
  }

  Future<void> _loadSavedTeam() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      decide = prefs.containsKey('savedTeam');
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.04;

    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(bottom: 20), // Prevents content from being cut off
              child: Column(
          children: [
            // Mode Toggle


            // Welcome Section
            !decide?
            Container(
              margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover, // Ensures the image covers the entire screen
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.asset("assets/images/logodz.png"),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'premier_league'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'welcome_to_fantasy'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'official_game_subtitle'.tr(),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ActionButton(
                    text: 'pick_team'.tr(),
                    backgroundColor: const Color(0xFF00FF9D),
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickTeamNameScreen(
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                ],
              ),
            ):
            Container(
              width: MediaQuery.of(context).size.width*0.93,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
                  fit: BoxFit.cover, // Ensures the image covers the entire screen
                ),
              ),
              child: Column(
                children: [

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            '87',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Average',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                '${points}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                'Points ',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16,
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 16,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [Text(
                          '201',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                          Text(
                            'Highest',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Gameweek  Deadline: Fri 14 Feb, 19:30',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00FF9D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TeamDetailsScreen()),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.people, color: Colors.black),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Pick Team',
                                    style: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00FF9D),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.swap_horiz, color: Colors.black),
                                const SizedBox(width: 8),
                                Text(
                                  'Transfers',
                                  style: TextStyle(
                                    color: Colors.grey[900],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final savedTeam = prefs.getString('savedTeam');

                      if (savedTeam != null) {
                        final teamData = jsonDecode(savedTeam);
                        final players = teamData['players'] as Map<String, dynamic>;



                        final random = Random();
                        int totalPoints = 0;

                        players.forEach((key, value) {
                          // Generate random performance metrics
                          final isGoalkeeperOrDefender = ['Goalkeeper', 'Defender'].contains(value['position']);
                          final goals = random.nextInt(3); // 0-2 goals (60% chance of 0)
                          final assists = random.nextInt(2); // 0-1 assists (50% chance of 0)
                          final cleanSheets = isGoalkeeperOrDefender ? random.nextInt(2) : 0; // 0-1
                          final yellowCards = random.nextInt(3); // 0-2
                          final redCards = random.nextInt(5) == 0 ? 1 : 0; // 20% chance of red card

                          // Calculate points
                          int playerPoints = (goals * 5) +
                              (assists * 3) +
                              (cleanSheets * 4) -
                              (yellowCards * 2) -
                              (redCards * 5);

                          // 30% chance to get 0 points regardless of performance
                          if (random.nextInt(10) < 3) playerPoints = 0;

                          totalPoints += playerPoints;
                        });

                        setState(() {
                          points += totalPoints; // Update points
                        });

                        // Show results
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Gameweek Results"),
                            content: Text("Your team scored $points points!"),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK")
                              )
                            ],
                          ),
                        );
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00FF9D),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Start Gameweek ',
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),
            // Draft Banner
            Container(
              margin: EdgeInsets.all(horizontalPadding),
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                  colors: [Color(0xFFD21034), Color(0xFF00FF9D)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset("assets/images/logodz.png"),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'fantasy_draft'.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'play_now'.tr(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),

            // News & Video Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'news_and_video'.tr(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text(
                          'view_all'.tr(),
                          style: const TextStyle(
                            color: Color(0xFF2C1752),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF2C1752),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Video Cards
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                children: [
                  _VideoCard(
                    thumbnail: 'assets/images/img_1.png',
                    duration: '1:36',
                    title: 'fpl_pod_liverpool'.tr(),
                    badges: const ['AD', 'CC'],
                  ),
                  const SizedBox(width: 15),
                  _VideoCard(
                    thumbnail: 'assets/images/img.png',
                    duration: '2:45',
                    title: 'scout_selection'.tr(),
                    badges: const ['CC'],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
          )
      )
    );
  }
}


class _VideoCard extends StatelessWidget {
  final String thumbnail;
  final String duration;
  final String title;
  final List<String> badges;

  const _VideoCard({
    required this.thumbnail,
    required this.duration,
    required this.title,
    required this.badges,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.asset(
                  thumbnail,
                  height: 120,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 16,
                      ),
                      Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Row(
                  children: badges
                      .map(
                        (badge) => Container(
                      margin: const EdgeInsets.only(left: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

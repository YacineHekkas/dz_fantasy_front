import 'package:flutter/material.dart';

class LatestMatchesScreen extends StatelessWidget {
  const LatestMatchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),

              const SizedBox(height: 10),
              // Matchday Live Text
              const Text(
                'Matchday Live',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Date
              const Text(
                'Saturday 15 February',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              // Matches List
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildMatchCard(
                      'ESS',
                      'CSC',
                      'assets/Club_Kits/crb_kit.png',
                      'assets/Club_Kits/crb_kit.png',
                      '13:30',
                    ),
                    _buildMatchCard(
                      'USMA',
                      'MCA',
                      'assets/Club_Kits/mca_kit.png',
                      'assets/Club_Kits/crb_kit.png',
                      '16:00',
                    ),
                    _buildMatchCard(
                      'USMA',
                      'MCA',
                      'assets/Club_Kits/mca_kit.png',
                      'assets/Club_Kits/crb_kit.png',
                      '16:00',
                    ),
                    _buildMatchCard(
                      'CRB',
                      'CSC',
                      'assets/Club_Kits/mca_kit.png',
                      'assets/Club_Kits/crb_kit.png',
                      '16:00',
                    ),
                    _buildMatchCard(
                      'MCO',
                      'SAOURA',
                      'assets/Club_Kits/mca_kit.png',
                      'assets/Club_Kits/crb_kit.png',
                      '16:00',
                    ),
                    _buildMatchCard(
                      'ESS',
                      'CSC',
                      'assets/Club_Kits/mca_kit.png',
                      'assets/Club_Kits/crb_kit.png',
                      '16:00',
                    ),
                  ],
                ),
              ),
              // Bottom Navigation Bar
              BottomNavigationBar(
                currentIndex: 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.article_outlined),
                    label: 'Latest',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sports_soccer),
                    label: 'PL',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.sports_esports),
                    label: 'Fantasy',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.bar_chart),
                    label: 'Stats',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.more_horiz),
                    label: 'More',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCard(
      String homeTeam,
      String awayTeam,
      String homeTeamLogo,
      String awayTeamLogo,
      String time,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    homeTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(homeTeamLogo, height: 24),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                time,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(awayTeamLogo, height: 24),
                  const SizedBox(width: 8),
                  Text(
                    awayTeam,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
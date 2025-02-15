import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> topThree = const [
    {
      'name': 'Kalam Suresh',
      'points': '49,999',
      'rank': 1,
      'image': 'assets/profile1.png',
    },
    {
      'name': 'John Raj',
      'points': '33,233',
      'rank': 2,
      'image': 'assets/profile2.png',
    },
    {
      'name': 'Harsh Dave',
      'points': '30,442',
      'rank': 3,
      'image': 'assets/profile3.png',
    },
  ];

  final List<Map<String, dynamic>> popularUsers = const [
    {
      'name': 'Alex Ensina',
      'points': '42,123',
      'rank': 4,
      'image': 'assets/profile4.png',
    },
    {
      'name': 'Jack Luis',
      'points': '41,764',
      'rank': 5,
      'image': 'assets/profile5.png',
    },
    {
      'name': 'Nathanial Do',
      'points': '40,210',
      'rank': 6,
      'image': 'assets/profile6.png',
    },
    {
      'name': 'Majorie Kane',
      'points': '40,000',
      'rank': 7,
      'image': 'assets/profile7.png',
    },
    {
      'name': 'Karl Xie',
      'points': '39,642',
      'rank': 8,
      'image': 'assets/profile8.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            height: 250,
            padding: const EdgeInsets.symmetric(vertical: 20),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildTopThreeItem(topThree[1], 2), // Second place
                _buildTopThreeItem(topThree[0], 1), // First place
                _buildTopThreeItem(topThree[2], 3), // Third place
              ],
            ),
          ),

          Expanded(
            child: Container(
              color: Colors.transparent,
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'POPULAR',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ...popularUsers.map((user) => _buildPopularUserItem(user)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopThreeItem(Map<String, dynamic> user, int position) {
    final Color medalColor = position == 1
        ? const Color(0xFFFFD700)
        : position == 2
        ? const Color(0xFFC0C0C0)
        : const Color(0xFFCD7F32);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: medalColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: position == 1 ? 50 : 40,
                backgroundImage: AssetImage(user['image']),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: medalColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                position.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          user['name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        Text(
          user['points'],
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildPopularUserItem(Map<String, dynamic> user) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '#${user['rank']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(user['image']),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                user['points'],
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
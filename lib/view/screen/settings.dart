import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sign Out Button
          SizedBox(height: 40,),
            // Settings Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
            ),

            // Settings Options
            _buildSettingItem('Manage Account', Icons.person, true),
            _buildSettingItem('Notifications', Icons.notifications, true),

            const SizedBox(height: 20),

            // Favourite Team Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Favourite Team',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
            ),

            // Arsenal Team Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset('assets/Club_Kits/csc_kit.png', height: 40),
                  const SizedBox(width: 12),
                  const Text(
                    'CSC',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'EDIT',
                    style: TextStyle(
                      color: Color(0xFF4A148C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Club Links
            _buildLinkItem('Official App', Icons.open_in_new),
            _buildLinkItem('Official Website', Icons.open_in_new),
            _buildLinkItem('Club Ticketing Information', Icons.open_in_new),
            _buildLinkItem('Digital Membership', Icons.open_in_new),


            const Spacer(),

            // Bottom Navigation Bar
            BottomNavigationBar(
              currentIndex: 4,
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
    );
  }

  Widget _buildSettingItem(String title, IconData icon, bool showArrow) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: showArrow
          ? const Icon(Icons.arrow_forward_ios, size: 16)
          : null,
      onTap: () {
        // Handle tap
      },
    );
  }

  Widget _buildLinkItem(String title, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(icon, size: 20),
      onTap: () {
        // Handle tap
      },
    );
  }
}
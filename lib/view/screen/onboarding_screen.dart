import 'package:dz_fantasy/view/screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/actionButton.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  static const List<String> kitImages = [
    'akbou_kit.png',
    'asoc_kit.png',
    'bayadh_kit.png',
    'crb_kit.png',
    'csc_kit.png',
    'esm_kit.png',
    'ess_kit.png',
    'jsk_kit.png',
    'mco_kit.png',
    'nmagra_kit.png',
    'parado_kit.png',
    'saoura_kit.png',
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    // Calculate responsive sizes
    final double paddingHorizontal = screenWidth * 0.06;
    final double titleFontSize = screenWidth * 0.06;
    final double subtitleFontSize = screenWidth * 0.04;
    final double buttonHeight = screenHeight * 0.06;
    final double logoSize = screenWidth * 0.15;
    final double gridSpacing = screenWidth * 0.03;

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () => _finishOnboarding(context),
                  child: Text(
                    'skip'.tr(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'pick_teams'.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'pick_teams_subtitle'.tr(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'search_teams'.tr(),
                    hintStyle: const TextStyle(color: Colors.white60),
                    prefixIcon: const Icon(Icons.search, color: Colors.white60),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'teams_in_competition'.tr(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Teams Grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(paddingHorizontal),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: screenWidth > 600 ? 6 : 4,
                      crossAxisSpacing: gridSpacing,
                      mainAxisSpacing: gridSpacing,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: kitImages.length, // Updated itemCount
                    itemBuilder: (context, index) {
                      final String teamName =
                      kitImages[index].split('_')[0].toUpperCase();
                      return Column(
                        children: [
                          Container(
                            width: logoSize,
                            height: logoSize,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/clubs/${kitImages[index]}'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(logoSize / 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          Text(
                            teamName,
                            style: TextStyle(
                              color: Colors.white, // Changed to white for visibility
                              fontSize: screenWidth * 0.03,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),


              // Continue Button
              Padding(
                padding: EdgeInsets.all(paddingHorizontal),
                child: SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child:
                  ActionButton(
                      text: 'continue'.tr(),
                      backgroundColor: const Color(0xFF00FF9D),
                      textColor: Colors.black,
                      onPressed: ()
                      {_finishOnboarding(context);
                      }
                  )

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }
}
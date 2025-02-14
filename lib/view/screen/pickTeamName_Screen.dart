import 'package:dz_fantasy/view/screen/createTeam_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../component/actionButton.dart';

class PickTeamNameScreen extends StatefulWidget {
  const PickTeamNameScreen({super.key});

  @override
  State<PickTeamNameScreen> createState() => _PickTeamNameScreenState();
}

class _PickTeamNameScreenState extends State<PickTeamNameScreen> {
  final _teamNameController = TextEditingController();
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.centerLeft,
          //   colors: [
          //     Color(0xFFD21034),
          //     Color(0xFF00FF9D), // Light Blue
          //     Color(0xFFFFFFFF),
          //     Color(0xFFFFFFFF), // White
          //      // Green
          //   ],
          //   stops: [0.0, 0.15,0.3, 0.5],
          // ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/logodz.png",
                            height: 120,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 40),
                        Text(
                          'pick your team name'.tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: TextField(
                            controller: _teamNameController,
                            decoration: InputDecoration(
                              hintText: 'enter_team_name'.tr(),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              value: _acceptedTerms,
                              onChanged: (value) {
                                setState(() {
                                  _acceptedTerms = value ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _acceptedTerms = !_acceptedTerms;
                                  });
                                },
                                child: RichText(
                                  text: TextSpan(
                                    text: '${'i_accept'.tr()} ',
                                    style: const TextStyle(color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text: 'terms_and_conditions'.tr(),
                                        style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child:
                          ActionButton(
                            text: 'select_name'.tr(),
                            backgroundColor: const Color(0xFF00FF9D),
                            textColor: Colors.black,
                             onPressed: ()
                                {
                                   _acceptedTerms && _teamNameController.text.isNotEmpty?
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                       builder: (context) => CreateTeamScreen(
                                         teamName: _teamNameController.text,
                                       ),
                                     ),
                                   ):
                                       null;


                          }
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _teamNameController.dispose();
    super.dispose();
  }
}
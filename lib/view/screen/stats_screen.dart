import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('stats'.tr()),
      ),
      body: Center(
        child: Text('stats_content'.tr()),
      ),
    );
  }
}
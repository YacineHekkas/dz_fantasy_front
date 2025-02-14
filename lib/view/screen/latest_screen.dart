import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LatestScreen extends StatelessWidget {
  const LatestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('latest'.tr()),
      ),
      body: Center(
        child: Text('latest_content'.tr()),
      ),
    );
  }
}
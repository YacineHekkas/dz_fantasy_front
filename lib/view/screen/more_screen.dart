import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('more'.tr()),
      ),
      body: Center(
        child: Text('more_content'.tr()),
      ),
    );
  }
}
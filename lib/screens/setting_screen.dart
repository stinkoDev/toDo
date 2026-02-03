import 'package:flutter/material.dart';
import 'package:to_do/widgets/safe_scaffold.dart';
import 'package:to_do/widgets/view_heading.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ViewHeading(title: 'settings screen')],
        ),
      ),
    );
  }
}

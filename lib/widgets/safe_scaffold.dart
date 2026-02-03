import 'package:flutter/material.dart';
import './bottom_nav.dart'; // Your BottomNavigation

class SafeScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;

  const SafeScaffold({super.key, required this.body, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(bottom: false, child: body),
      bottomNavigationBar:
          bottomNavigationBar ?? BottomNavigation(), // Default bottom nav
    );
  }
}

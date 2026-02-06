import 'package:flutter/material.dart';
import './bottom_nav.dart';

class SafeScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appbar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const SafeScaffold({
    super.key,
    required this.body,
    this.appbar,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: appbar,
      body: SafeArea(bottom: false, child: body),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar:
          bottomNavigationBar ?? BottomNavigation(), // Default bottom nav
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/nav_provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final Map<int, String> valueMap = {0: '/settings', 1: '/home', 2: '/create'};

  @override
  Widget build(BuildContext context) {
    return Consumer<NavProvider>(
      builder: (context, nav, child) {
        return Container(
          decoration: BoxDecoration(
            color:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor ??
                Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            selectedIndex: nav.selected,
            onDestinationSelected: (int newSelection) {
              final newIndex = newSelection;
              Provider.of<NavProvider>(context, listen: false).select(newIndex);
              context.go(valueMap[newIndex]!);
            },

            destinations: [
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              NavigationDestination(icon: Icon(Icons.notes), label: 'Notes'),
              NavigationDestination(
                icon: Icon(Icons.browse_gallery),
                label: 'Stats',
              ),
            ],
          ),
        );
      },
    );
  }
}

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
  final Map<int, String> valueMap = {1: '/settings', 2: '/home', 3: '/create'};

  @override
  Widget build(BuildContext context) {
    return Consumer<NavProvider>(
      builder: (context, nav, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SegmentedButton(
                  style: SegmentedButton.styleFrom(
                    side: BorderSide.none,
                    selectedBackgroundColor: Theme.of(
                      context,
                    ).colorScheme.onInverseSurface,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  showSelectedIcon: false,
                  segments: const <ButtonSegment<int>>[
                    ButtonSegment<int>(
                      value: 1,
                      label: Text('Settings'),
                      icon: Icon(Icons.settings),
                    ),
                    ButtonSegment<int>(
                      value: 2,
                      label: Text('Home'),
                      icon: Icon(Icons.notes),
                    ),
                    ButtonSegment<int>(
                      value: 3,
                      label: Text('Create note'),
                      icon: Icon(Icons.add),
                    ),
                  ],
                  selected: {nav.selected},
                  onSelectionChanged: (Set<int> newSelection) {
                    final newIndex = newSelection.first;
                    setState(() {});
                    Provider.of<NavProvider>(
                      context,
                      listen: false,
                    ).select(newIndex);
                    context.go(valueMap[newIndex]!);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

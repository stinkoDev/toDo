import 'package:flutter/material.dart';
import 'package:to_do/widgets/view_heading.dart';

class ThoughtsView extends StatefulWidget {
  const ThoughtsView({super.key});
  @override
  State<ThoughtsView> createState() => _ThoughtsViewState();
}

class _ThoughtsViewState extends State<ThoughtsView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [ListTile(title: ViewHeading(title: 'THOUGHTS test page'))],
    );
  }
}

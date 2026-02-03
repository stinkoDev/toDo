import 'package:flutter/material.dart';
import 'package:to_do/widgets/view_heading.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});
  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [ListTile(title: ViewHeading(title: 'CALENDAR test page'))],
    );
  }
}

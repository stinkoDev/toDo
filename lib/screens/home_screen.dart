import 'package:flutter/material.dart';
import 'package:to_do/screens/to_do_view.dart';
import 'package:to_do/views/agenda_view.dart';
import 'package:to_do/views/calendar_view.dart';
import 'package:to_do/views/thougths_view.dart';
import 'package:to_do/widgets/safe_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _homeScreenController;

  @override
  void initState() {
    super.initState();
    _homeScreenController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _homeScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: PageView(
        controller: _homeScreenController,
        children: [ThoughtsView(), ToDoView(), AgendaView(), CalendarView()],
      ),
    );
  }
}

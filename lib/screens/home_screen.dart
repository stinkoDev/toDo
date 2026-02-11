import 'package:flutter/material.dart';
import 'package:to_do/views/home_view.dart';
import 'package:to_do/views/to_do_view.dart';
import 'package:to_do/views/agenda_view.dart';
import 'package:to_do/views/calendar_view.dart';
import 'package:to_do/views/thougths_view.dart';
import 'package:to_do/widgets/create_floating_action_button.dart';
import 'package:to_do/widgets/safe_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _homeScreenController;
  int _currentIndex = 1;
  String _currentTitle = 'To Do...';

  @override
  void initState() {
    super.initState();
    _homeScreenController = PageController(initialPage: _currentIndex);
    _homeScreenController.addListener(_onPageChange);
  }

  void _onPageChange() => setState(() {
    _currentIndex = _homeScreenController.page!.round();
  });

  Widget _getFloatingActionButton(int index) {
    switch (index) {
      case 0:
        _currentTitle = 'Thoughts...';
        return CreateFloatingActionButton(
          title: 'Create Thought',
          prompt: 'Thought',
          type: 'thought',
        );
      case 1:
        _currentTitle = 'To Do...';
        return CreateFloatingActionButton(
          title: 'Create Task',
          prompt: 'To Do',
          type: 'todo',
        );
      case 2:
        _currentTitle = 'Agenda...';
        return CreateFloatingActionButton(
          title: 'Create Event',
          prompt: 'Event',
          type: 'event',
        );
      case 3:
        _currentTitle = 'Calendar...';
        return CreateFloatingActionButton(
          title: 'Add Event',
          prompt: 'Event',
          type: 'event',
        );
      default:
        return Container();
      // _currentTitle = 'error';
      // return CreateFloatingActionButton(title: '', prompt: '', type: '');
    }
  }

  @override
  void dispose() {
    _homeScreenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appbar: AppBar(
        title: Text(_currentTitle),
        elevation: 2,
        shadowColor: Colors.black38,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      body: PageView(
        controller: _homeScreenController,
        onPageChanged: (index) => setState(() {
          _currentIndex = index;
        }),
        children: [
          ThoughtsView(),
          ToDoView(),
          AgendaView(),
          CalendarView(),
          HomeView(),
        ],
      ),
      floatingActionButton: _getFloatingActionButton(_currentIndex),
    );
  }
}

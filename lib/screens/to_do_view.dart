import 'package:flutter/material.dart';
import 'package:to_do/widgets/to_do_widget.dart';
import 'package:to_do/widgets/view_heading.dart';
import 'package:to_do/models/to_do_item.dart';

class ToDoView extends StatefulWidget {
  const ToDoView({super.key});
  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  final now = DateTime.now();

  late List<ToDoItem> todos = [
    ToDoItem(
      title: 'Buy groceries',
      createdAt: DateTime(2023, 1, 18, 14, 30),
      completion: false,
    ),
    ToDoItem(
      title: 'Reply to work emails',
      createdAt: DateTime(2023, 1, 19, 9, 15),
      completion: true,
    ),
    ToDoItem(
      title: 'Schedule dentist appointment',
      createdAt: DateTime(2023, 1, 20, 11, 45),
      completion: false,
    ),
    ToDoItem(
      title: 'Finish chapter 3 of book',
      createdAt: DateTime(2023, 1, 21, 20, 10),
      completion: false,
    ),
    ToDoItem(
      title: 'Pay electricity bill',
      createdAt: DateTime(2023, 1, 22, 16, 20),
      completion: true,
    ),
    ToDoItem(
      title: 'Call plumber about leak',
      createdAt: DateTime(2023, 1, 23, 13, 5),
      completion: false,
    ),
    ToDoItem(
      title: 'Update resume',
      createdAt: DateTime(2023, 1, 24, 10, 30),
      completion: false,
    ),
    ToDoItem(
      title: 'Buy birthday gift for Sarah',
      createdAt: DateTime(2023, 1, 25, 18, 40),
      completion: true,
    ),
    ToDoItem(
      title: 'Clean kitchen',
      createdAt: DateTime(2023, 1, 26, 19, 0),
      completion: false,
    ),
    ToDoItem(
      title: 'Book flight tickets',
      createdAt: DateTime(2023, 1, 27, 12, 25),
      completion: true,
    ),
    ToDoItem(
      title: 'Water plants',
      createdAt: DateTime(2023, 1, 28, 8, 10),
      completion: false,
    ),
    ToDoItem(
      title: 'Fix broken shelf',
      createdAt: DateTime(2023, 1, 29, 17, 50),
      completion: false,
    ),
    ToDoItem(
      title: 'Plan weekend trip',
      createdAt: DateTime(2023, 1, 30, 15, 35),
      completion: false,
    ),
    ToDoItem(
      title: 'Send thank you email',
      createdAt: DateTime(2023, 1, 31, 14, 20),
      completion: true,
    ),
    ToDoItem(
      title: 'Organize desk',
      createdAt: DateTime(2023, 2, 1, 10, 0),
      completion: false,
    ),
  ];

  void toggleCompletion(String id, bool newValue) {
    setState(() {
      todos = todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(completion: newValue);
        }
        return todo;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var sortedTodos = todos.toList()
      ..sort((a, b) {
        if (a.completion != b.completion) {
          return a.completion ? 1 : -1;
        }
        return b.createdAt.compareTo(a.createdAt);
      });

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 10),
      child: ListView(
        children: [
          const ViewHeading(title: 'To Do...'),
          ...sortedTodos.map((todo) {
            return ToDoWidget(
              id: todo.id,
              title: todo.title,
              createdAt: todo.createdAt,
              completion: todo.completion,
              onToggle: (bool value) {
                toggleCompletion(todo.id, value);
              },
            );
          }),
        ],
      ),
    );
  }
}

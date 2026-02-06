import 'package:flutter/material.dart';
import 'package:to_do/widgets/custom_divider.dart';
import 'package:to_do/widgets/to_do_dropdown.dart';
import 'package:to_do/widgets/to_do_widget.dart';
import 'package:to_do/models/to_do_item.dart';
import 'package:to_do/services/to_do_service.dart';

class ToDoView extends StatefulWidget {
  const ToDoView({super.key});
  @override
  State<ToDoView> createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  final now = DateTime.now();

  late List<String> dropDownCatagoryList;
  late List<String> dropDownSortList;
  late String dropDownCatagorySelected;
  late String dropDownSortSelected;
  List<ToDoItem> todos = [];

  @override
  void initState() {
    super.initState();

    dropDownSortList = [
      'Newest First',
      'Oldest First',
      'Highest Priority',
      'Lowest Priority',
      'Random',
    ];

    dropDownCatagoryList = ['All', 'High', 'Medium', 'Normal'];
    dropDownCatagorySelected = dropDownCatagoryList.first;
    dropDownSortSelected = dropDownSortList.first;

    todos = TodoService.getAll();
  }

  void toggleCompletion(String id, bool newValue) async {
    await TodoService.toggle(id, newValue);

    setState(() {
      todos = TodoService.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    var filteredTodos = dropDownCatagorySelected == 'All'
        ? TodoService.getAll()
        : TodoService.filterByPriority(dropDownCatagorySelected);
    var sortedTodos = TodoService.sortByCategory(
      filteredTodos,
      dropDownSortSelected,
    );

    var incompleteToDo = sortedTodos.where((todo) => !todo.completion).toList();
    var completedToDo = sortedTodos.where((todo) => todo.completion).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 10),
      child: ListView(
        children: [
          ToDoDropdown(
            selected_1: dropDownSortSelected,
            options_1: dropDownSortList,
            selected_2: dropDownCatagorySelected,
            options_2: dropDownCatagoryList,
            onChanged_1: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  dropDownSortSelected = newValue;
                });
              }
            },
            onChanged_2: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  dropDownCatagorySelected = newValue;
                });
              }
            },
          ),

          ...incompleteToDo.map((todo) {
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
          CustomDivider(data: 'Completed'),
          ...completedToDo.map((todo) {
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

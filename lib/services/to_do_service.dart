import 'package:hive_flutter/hive_flutter.dart';
import '../models/to_do_item.dart';

class TodoService {
  static Box<ToDoItem>? _todosBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ToDoItemAdapter());
    _todosBox = await Hive.openBox<ToDoItem>('todos');
    await seedData();
    print('✅ Hive ready! ${_todosBox?.length ?? 0} todos loaded');
  }

  static List<ToDoItem> getAll() {
    return _todosBox?.values.toList() ?? [];
  }

  static Future<void> toggle(String id, bool newValue) async {
    final todo = _todosBox?.get(id);
    if (todo != null) {
      todo.completion = newValue;
      await _todosBox?.put(id, todo);
      print('✅ Toggled todo $id → $newValue');
    }
  }

  static List<ToDoItem> filterByPriority(String priorityFilter) {
    final allToDos = getAll();
    if (priorityFilter.toLowerCase() == 'all') return allToDos;
    return allToDos
        .where(
          (todo) => todo.priority.toLowerCase() == priorityFilter.toLowerCase(),
        )
        .toList();
  }

  static List<ToDoItem> sortByCategory(List<ToDoItem> todos, String sortType) {
    switch (sortType) {
      case 'Newest First':
        return todos..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case 'Oldest First':
        return todos..sort((a, b) => a.createdAt.compareTo(b.createdAt));
      case 'Highest Priority':
        return todos..sort(
          (a, b) =>
              _priorityValue(b.priority).compareTo(_priorityValue(a.priority)),
        );
      case 'Lowest Priority':
        return todos..sort(
          (a, b) =>
              _priorityValue(a.priority).compareTo(_priorityValue(b.priority)),
        );
      case 'Random':
        todos.shuffle();
        return todos;
      default:
        return todos;
    }
  }

  static int _priorityValue(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return 3;
      case 'medium':
        return 2;
      case 'normal':
        return 1;
      default:
        return 0;
    }
  }

  static Future<void> seedData() async {
    if (_todosBox!.isEmpty) {
      // Only if empty
      final sampleTodos = [
        ToDoItem(title: 'Buy groceries', completion: false, priority: 'high'),
        ToDoItem(title: 'Clean kitchen', completion: false, priority: 'normal'),
        ToDoItem(title: 'Call mom', completion: true, priority: 'medium'),
      ];
      for (var todo in sampleTodos) {
        await _todosBox!.put(todo.id, todo);
      }
      print('✅ Added 3 sample todos!');
    }
  }
}

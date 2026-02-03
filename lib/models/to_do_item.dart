import 'package:uuid/uuid.dart';

class ToDoItem {
  final String id;
  final String title;
  final DateTime createdAt;
  final bool completion; // ← stays final

  ToDoItem({
    String? id,
    required this.title,
    DateTime? createdAt,
    required this.completion,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now();

  ToDoItem copyWith({bool? completion}) {
    return ToDoItem(
      id: id,
      title: title,
      createdAt: createdAt,
      completion: completion ?? this.completion,
    );
  }

  factory ToDoItem.create({required String title}) {
    return ToDoItem(title: title, completion: false);
  }
}

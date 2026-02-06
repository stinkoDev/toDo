import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'to_do_item.g.dart';

@HiveType(typeId: 0)
class ToDoItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  bool completion;

  @HiveField(4)
  final String priority;

  ToDoItem({
    String? id,
    required this.title,
    DateTime? createdAt,
    required this.completion,
    String? priority,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       priority = priority ?? 'normal';

  ToDoItem copyWith({bool? completion}) {
    return ToDoItem(
      id: id,
      title: title,
      createdAt: createdAt,
      priority: priority,
      completion: completion ?? this.completion,
    );
  }

  factory ToDoItem.create({required String title}) {
    return ToDoItem(title: title, completion: false, priority: 'normal');
  }
}

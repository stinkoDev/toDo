import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'to_do_item.g.dart';

@HiveType(typeId: 0)
class ToDoItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  bool reqDescription;

  @HiveField(4)
  final DateTime dateCreated;

  @HiveField(5)
  DateTime? dateFinished;

  @HiveField(6)
  bool completion;

  @HiveField(7)
  String priority;

  @HiveField(8)
  DateTime? dueDate;

  @HiveField(9)
  bool reqDueDate;

  @HiveField(10)
  bool allDay;

  ToDoItem({
    String? id,
    required this.title,
    this.description,
    this.reqDescription = false,
    DateTime? dateCreated,
    this.dateFinished,
    required this.completion,
    String? priority,
    this.dueDate,
    this.reqDueDate = false,
    this.allDay = false,
  }) : id = id ?? const Uuid().v4(),
       dateCreated = dateCreated ?? DateTime.now(),
       priority = priority ?? 'normal';

  ToDoItem copyWith({
    String? title,
    String? description,
    bool? reqDescription,
    bool? completion,
    String? priority,
    DateTime? dateFinished,
    DateTime? dueDate,
    bool? reqDueDate,
    bool? allDay,
  }) {
    return ToDoItem(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateCreated: dateCreated,
      priority: priority ?? this.priority,
      completion: completion ?? this.completion,
      dateFinished: dateFinished ?? this.dateFinished,
      reqDescription: reqDescription ?? this.reqDescription,
      dueDate: dueDate ?? this.dueDate,
      reqDueDate: reqDueDate ?? this.reqDueDate,
      allDay: allDay ?? this.allDay,
    );
  }

  factory ToDoItem.create({required String title}) {
    return ToDoItem(title: title, completion: false);
  }
}

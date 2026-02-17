import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'note_item.g.dart';

@HiveType(typeId: 1)
class NoteItem extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String content; // Markdown string

  @HiveField(2)
  String? title;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  NoteItem({
    String? id,
    required this.content,
    this.title,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  String get displayTitle {
    if (title?.isNotEmpty == true) return title!;
    final firstLine = content.split('\n').first.trim();
    if (firstLine.isEmpty) return 'Untitled';
    final clean = firstLine.replaceAll(RegExp(r'[#*_~`\[\]]'), '').trim();
    return clean.length > 30 ? '${clean.substring(0, 30)}...' : clean;
  }

  String get previewText {
    final clean = content
        .replaceAll(RegExp(r'\*\*.*?\*\*'), '')
        .replaceAll(RegExp(r'[-*]\s?\[.\]\s?'), '')
        .replaceAll(RegExp(r'[#*_~`]'), '')
        .trim();
    return clean.length > 100 ? '${clean.substring(0, 100)}...' : clean;
  }
}

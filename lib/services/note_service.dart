import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/models/note_item.dart';

class NoteService {
  static Box<NoteItem>? _notesBox;
  static Box<NoteItem>? get box => _notesBox;

  static Future<void> init() async {
    Hive.registerAdapter(NoteItemAdapter());
    _notesBox = await Hive.openBox<NoteItem>('notes');
    await seedData();

    print("\n=== 📝 NOTES DATA DUMP START 📝 ===");
    if (_notesBox!.isEmpty) {
      print("Notes database is empty.");
    } else {
      for (var i = 0; i < _notesBox!.length; i++) {
        final note = _notesBox!.getAt(i);
        print("Note #$i:");
        print("  📌 ID: ${note?.id}");
        print("  📌 Title: ${note?.displayTitle}");
        print("  📌 Content: ${note?.previewText}");
        print("  📌 Created: ${note?.createdAt}");
        print("  📌 Updated: ${note?.updatedAt}");
        print("-----------------------------------");
      }
    }
    print("=== 📝 NOTES DATA DUMP END 📝 ===\n");
  }

  static List<NoteItem> getAll() {
    return _notesBox?.values.toList() ?? [];
  }

  static List<NoteItem> getAllSorted() {
    final notes = getAll();
    return notes..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  static Future<void> create({required String content, String? title}) async {
    final newNote = NoteItem(content: content, title: title);
    await _notesBox?.put(newNote.id, newNote);
  }

  static NoteItem? getNote(String id) {
    return _notesBox?.get(id);
  }

  static Future<void> update(NoteItem note) async {
    note.updatedAt = DateTime.now();
    await _notesBox?.put(note.id, note);
  }

  static Future<void> updateContent(String id, String newContent) async {
    final note = _notesBox?.get(id);
    if (note != null) {
      note.content = newContent;
      note.updatedAt = DateTime.now();
      await _notesBox?.put(id, note);
    }
  }

  static Future<NoteItem?> softDelete(String id) async {
    final note = _notesBox?.get(id);
    if (note != null) {
      await _notesBox?.delete(id);
      return note;
    }
    return null;
  }

  static Future<void> restore(NoteItem note) async {
    await _notesBox?.put(note.id, note);
  }

  static List<NoteItem> search(String query) {
    if (query.isEmpty) return getAllSorted();

    final lowerQuery = query.toLowerCase();
    return getAll()
        .where(
          (note) =>
              note.displayTitle.toLowerCase().contains(lowerQuery) ||
              note.content.toLowerCase().contains(lowerQuery),
        )
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  static Future<void> seedData() async {
    if (_notesBox!.isEmpty) {
      final sampleNotes = [
        NoteItem(
          content: '# Welcome to Notes\n\nStart writing your thoughts here!',
          title: 'Welcome',
        ),
        NoteItem(
          content: '## Shopping List\n\n- [ ] Milk\n- [ ] Eggs\n- [x] Bread',
          title: 'Shopping',
        ),
        NoteItem(
          content:
              'Remember to **call mom** this weekend.\n\nAlso check *email*.',
        ),
      ];
      for (var note in sampleNotes) {
        await _notesBox!.put(note.id, note);
      }
    }
  }

  static Future<void> clearAll() async {
    await _notesBox?.clear();
  }
}

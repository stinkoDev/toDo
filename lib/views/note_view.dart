import 'package:flutter/material.dart';
import 'package:to_do/widgets/note/note_preview.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});
  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  int count = 9;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 15, 8, 75),
      child: GridView.count(
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        children: [for (int i = 0; i < count; i++) NotePreview()],
      ),
    );
  }
}

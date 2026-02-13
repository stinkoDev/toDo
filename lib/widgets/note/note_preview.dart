import 'package:flutter/material.dart';

class NotePreview extends StatelessWidget {
  const NotePreview({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Title that is way too long for the space',
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              SizedBox(height: 5),
              Text('description', overflow: TextOverflow.fade, maxLines: 8),
              Spacer(),
              Text(
                'created: 2026/04/24',
                style: TextStyle(color: Theme.of(context).disabledColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

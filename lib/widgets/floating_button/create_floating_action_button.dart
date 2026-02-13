import 'package:flutter/material.dart';
import 'package:to_do/widgets/floating_button/create_dialog.dart';

class CreateFloatingActionButton extends StatelessWidget {
  final String prompt;
  final String type;
  final String title;

  const CreateFloatingActionButton({
    super.key,
    required this.prompt,
    required this.type,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => showDialog(
        context: context,
        builder: (context) =>
            CreateDialog(title: title, prompt: prompt, type: type),
      ),
      icon: const Icon(Icons.add),
      label: Text(prompt),
    );
  }
}

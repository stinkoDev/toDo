import 'package:flutter/material.dart';
import 'package:to_do/widgets/floating_button/custom_textfield.dart';

class DescriptionInput extends StatefulWidget {
  final Function(String?) onDescriptionChanged;

  const DescriptionInput({super.key, required this.onDescriptionChanged});

  @override
  State<DescriptionInput> createState() => _DescriptionInputState();
}

class _DescriptionInputState extends State<DescriptionInput> {
  late TextEditingController _descriptionController;
  bool _addDescription = false;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Add description'),
              Switch(
                value: _addDescription,
                onChanged: (value) {
                  setState(() => _addDescription = value);
                  widget.onDescriptionChanged(
                    value ? _descriptionController.text.trim() : null,
                  );
                },
              ),
            ],
          ),
        ),
        if (_addDescription)
          CustomTextfield(
            maxLines: 7,
            hint: 'description',
            controller: _descriptionController,
            onChanged: (text) {
              widget.onDescriptionChanged(
                text.trim().isEmpty ? null : text.trim(),
              );
            },
          ),
      ],
    );
  }
}

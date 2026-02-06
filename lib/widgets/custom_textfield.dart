import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String? hint;
  const CustomTextfield({super.key, this.hint});
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late TextEditingController _textFieldController;
  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: _textFieldController,
        decoration: InputDecoration(
          filled: true,
          hintText: widget.hint ?? '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String? hint;
  final bool? autoFocus;
  final int? maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  const CustomTextfield({
    super.key,
    this.hint,
    this.autoFocus,
    this.maxLines,
    this.controller,
    this.onChanged,
  });
  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLines: widget.maxLines ?? 1,
        autofocus: widget.autoFocus ?? false,
        minLines: 1,
        controller: _controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          filled: true,
          hintText: widget.hint ?? '',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
      ),
    );
  }
}

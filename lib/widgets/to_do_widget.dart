import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ToDoWidget extends StatefulWidget {
  final String id;
  final String title;
  final DateTime createdAt;
  final bool completion;
  final ValueChanged<bool> onToggle;

  const ToDoWidget({
    super.key,
    required this.id,
    required this.title,
    required this.createdAt,
    required this.completion,
    required this.onToggle,
  });
  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat("dd/MM/yyyy 'at' HH:mm");
    final formattedDate = formatter.format(widget.createdAt.toLocal());

    return Card(
      child: ListTile(
        title: Text(
          widget.title,
          style: TextStyle(
            decoration: widget.completion
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: widget.completion
                ? Theme.of(context).disabledColor
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          'created on $formattedDate',
          style: TextStyle(color: Theme.of(context).disabledColor),
        ),
        leading: Checkbox(
          value: widget.completion,
          onChanged: (bool? value) {
            if (value != null) {
              widget.onToggle(value);
            }
          },
        ),
      ),
    );
  }
}

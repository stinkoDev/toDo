import 'package:flutter/material.dart';
import 'package:to_do/services/to_do_service.dart';
import 'package:to_do/models/to_do_item.dart';
import 'package:to_do/utils/date.dart';

class ToDoWidget extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final bool reqDescription;
  final DateTime dateCreated;
  final DateTime dateFinished;
  final bool completion;
  final String priority;
  final DateTime dueDate;
  final bool reqDueDate;
  final bool allDay;
  final ValueChanged<bool> onToggle;
  final VoidCallback onDelete;

  const ToDoWidget({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.reqDescription,
    required this.dateCreated,
    required this.dateFinished,
    required this.completion,
    required this.priority,
    required this.dueDate,
    required this.reqDueDate,
    required this.allDay,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  @override
  Widget build(BuildContext context) {
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
        subtitle: widget.completion
            ? null
            : widget.reqDueDate
            ? (widget.allDay
                  ? Text(
                      lateDueDate(widget.dueDate)
                          ? 'Late! Due ${dateFormat(widget.dueDate)}'
                          : 'due ${dateFormat(widget.dueDate)}',
                      style: lateDueDate(widget.dueDate)
                          ? TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                            )
                          : TextStyle(color: Theme.of(context).disabledColor),
                    )
                  : Text(
                      lateDueDate(widget.dueDate)
                          ? 'Late! Due ${dateTimeFormat(widget.dueDate)}'
                          : 'due ${dateTimeFormat(widget.dueDate)}',
                      style: lateDueDate(widget.dueDate)
                          ? TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                            )
                          : TextStyle(color: Theme.of(context).disabledColor),
                    ))
            : null,
        leading: Checkbox(
          value: widget.completion,
          onChanged: (bool? value) {
            if (value != null) {
              widget.onToggle(value);
            }
          },
        ),
        trailing: switch (widget.priority) {
          'high' => Icon(
            Icons.warning_outlined,
            color: widget.completion
                ? Theme.of(context).disabledColor
                : Colors.red,
          ),
          'medium' => Icon(
            Icons.priority_high_outlined,
            color: widget.completion
                ? Theme.of(context).disabledColor
                : Colors.orange,
          ),
          _ => null,
        },
        onLongPress: () => widget.onToggle(!widget.completion),
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black45,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => SafeArea(
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 0.95,
                builder: (context, scrollController) => Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              widget.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description:'),
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: scrollController,
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.description,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleMedium,
                                        ),
                                        Text(
                                          'Created ${dateTimeFormat(widget.dateCreated)}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [_SegmentButton(widget: widget)],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SegmentButton extends StatefulWidget {
  final ToDoWidget widget;
  const _SegmentButton({required this.widget});

  @override
  State<_SegmentButton> createState() => _SegmentButtonState();
}

class _SegmentButtonState extends State<_SegmentButton> {
  bool _isDeleted = false;
  bool _localCompletion = false;
  ToDoItem? _deletedTodo;

  @override
  void initState() {
    super.initState();
    _localCompletion = widget.widget.completion;
  }

  Future<void> _handleDelete() async {
    if (_isDeleted) {
      await TodoService.restore(_deletedTodo!);
      setState(() => _isDeleted = false);
    } else {
      _deletedTodo = await TodoService.softDelete(widget.widget.id);
      setState(() => _isDeleted = true);
    }
  }

  Future<void> _handleToggle() async {
    final newCompletion = !_localCompletion;
    await TodoService.toggle(widget.widget.id, newCompletion);
    setState(() => _localCompletion = newCompletion);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            icon: Icon(_isDeleted ? Icons.undo_outlined : Icons.delete),
            label: Text(_isDeleted ? 'Undo' : 'Delete'),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(50),
                ),
              ),
            ),
            onPressed: () => _handleDelete(),
          ),
        ),
        Expanded(
          child: FilledButton.icon(
            icon: Icon(Icons.edit),
            label: Text('Edit'),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only()),
            ),
            onPressed: () {},
          ),
        ),
        Expanded(
          child: FilledButton.icon(
            icon: Icon(_localCompletion ? Icons.close : Icons.check),
            label: Text('done'),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(50),
                ),
              ),
            ),
            onPressed: () => _handleToggle(),
          ),
        ),
      ],
    );
  }
}

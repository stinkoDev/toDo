import 'package:flutter/material.dart';
import 'package:to_do/app/app_theme.dart';
import 'package:to_do/services/to_do_service.dart';
import 'package:to_do/widgets/custom_textfield.dart';

class CreateFloatingActionButton extends StatefulWidget {
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
  State<CreateFloatingActionButton> createState() =>
      _CreateFloatingActionButtonState();
}

class _CreateFloatingActionButtonState
    extends State<CreateFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => _AlertPopup(
          title: widget.title,
          prompt: widget.prompt,
          type: widget.type,
        ),
      ),
      icon: Icon(Icons.add),
      label: Text(widget.prompt),
    );
  }
}

class _AlertPopup extends StatefulWidget {
  final String title;
  final String prompt;
  final String type;

  const _AlertPopup({
    required this.title,
    required this.prompt,
    required this.type,
  });

  @override
  State<_AlertPopup> createState() => _AlertPopupState();
}

class _AlertPopupState extends State<_AlertPopup> {
  late TextEditingController _titleTextFieldController;
  late TextEditingController _descriptionTextFieldController;

  @override
  void initState() {
    super.initState();
    _titleTextFieldController = TextEditingController();
    _descriptionTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _titleTextFieldController.dispose();
    _descriptionTextFieldController.dispose();
    super.dispose();
  }

  String _selectedPriority = 'normal';
  bool _addDescription = false;
  bool _addDueDate = false;

  @override
  Widget build(BuildContext context) {
    final priorityColors = Theme.of(context).extension<PriorityColors>()!;
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // FilledButton(onPressed: () {}, child: Text(widget.title)),
            SegmentedButton(
              segments: [
                ButtonSegment(
                  label: Text('High'),
                  value: 'high',
                  icon: Icon(Icons.label_important_outline),
                ),
                ButtonSegment(
                  label: Text('Med'),
                  value: 'medium',
                  icon: Icon(Icons.label_important_outline),
                ),
                ButtonSegment(
                  label: Text('Std'),
                  value: 'normal',
                  icon: Icon(Icons.label_important_outline),
                ),
              ],

              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    switch (_selectedPriority) {
                      case 'high':
                        return priorityColors.high;
                      case 'medium':
                        return priorityColors.medium;
                      case 'normal':
                        return Theme.of(context).colorScheme.inversePrimary;
                      default:
                        return null;
                    }
                  }
                  return Colors.transparent;
                }),
              ),
              selected: {_selectedPriority},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedPriority = newSelection.first;
                });
              },
            ),
            CustomTextfield(
              hint: 'title',
              controller: _titleTextFieldController,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add description'),
                  Switch(
                    value: _addDescription,
                    onChanged: (value) => setState(() {
                      _addDescription = value;
                    }),
                  ),
                ],
              ),
            ),
            _addDescription
                ? CustomTextfield(
                    hint: 'description',
                    controller: _descriptionTextFieldController,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add due date'),
                  Switch(
                    value: _addDueDate,
                    onChanged: (value) => setState(() {
                      _addDueDate = value;
                    }),
                  ),
                ],
              ),
            ),
            _addDueDate ? _DateEntry() : Container(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_titleTextFieldController.text.trim().isEmpty) return;
            TodoService.create(
              title: _titleTextFieldController.text.trim(),
              description: _addDescription
                  ? _descriptionTextFieldController.text.trim()
                  : null,
              priority: _selectedPriority,
            );
            Navigator.pop(context);
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}

class _DateEntry extends StatefulWidget {
  @override
  State<_DateEntry> createState() => _DateEntryState();
}

class _DateEntryState extends State<_DateEntry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.calendar_today_outlined),
              Text('date'),
              Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.alarm_outlined),
              Text('time'),
              Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
      ],
    );
  }
}

// class _PopUp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Text('test');
//   }
// }

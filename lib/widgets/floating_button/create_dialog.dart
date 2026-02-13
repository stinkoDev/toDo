import 'package:flutter/material.dart';
import 'package:to_do/services/to_do_service.dart';
import 'package:to_do/utils/date.dart';
import 'package:to_do/widgets/floating_button/custom_textfield.dart';
import 'package:to_do/widgets/floating_button/priority_selector.dart';
import 'package:to_do/widgets/floating_button/description_input.dart';
import 'package:to_do/widgets/floating_button/date_picker_section.dart';

class CreateDialog extends StatefulWidget {
  final String title;
  final String prompt;
  final String type;

  const CreateDialog({
    super.key,
    required this.title,
    required this.prompt,
    required this.type,
  });

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  late TextEditingController _titleController;

  late String _selectedPriority;
  late String? _description;
  late DateTime? _selectedDate;
  late TimeOfDay? _selectedTime;
  late bool _allDay;
  late bool _addDueDate;
  late bool _addDescription;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _selectedPriority = 'normal';
    _description = null;
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    _allDay = true;
    _addDueDate = true;
    _addDescription = false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  DateTime _getDueDate() {
    final dateTime = _addDueDate
        ? fullDateTime(_selectedDate ?? today(), _allDay ? null : _selectedTime)
        : today();
    return dateTime ?? today();
  }

  void _handleCreate() {
    if (_titleController.text.trim().isEmpty) return;

    TodoService.create(
      title: _titleController.text.trim(),
      description: _description,
      priority: _selectedPriority,
      dueDate: _getDueDate(),
      reqDescription: _addDescription,
      reqDueDate: _addDueDate,
      allDay: _allDay,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrioritySelector(
              selectedPriority: _selectedPriority,
              onPriorityChanged: (priority) {
                setState(() => _selectedPriority = priority);
              },
            ),
            CustomTextfield(
              hint: 'title',
              autoFocus: true,
              controller: _titleController,
            ),
            DescriptionInput(
              onDescriptionChanged: (description) {
                setState(() => _description = description);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Add due date'),
                  Switch(
                    value: _addDueDate,
                    onChanged: (value) => setState(() => _addDueDate = value),
                  ),
                ],
              ),
            ),
            if (_addDueDate)
              DatePickerSection(
                selectedDate: _selectedDate,
                selectedTime: _selectedTime,
                allDay: _allDay,
                onDateChanged: (date) => setState(() => _selectedDate = date),
                onTimeChanged: (time) => setState(() => _selectedTime = time),
                onAllDayChanged: (value) => setState(() => _allDay = value),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _handleCreate, child: const Text('Create')),
      ],
    );
  }
}

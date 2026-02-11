import 'package:flutter/material.dart';
import 'package:to_do/utils/date.dart';

class DatePickerSection extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final bool allDay;
  final Function(DateTime?) onDateChanged;
  final Function(TimeOfDay?) onTimeChanged;
  final Function(bool) onAllDayChanged;

  const DatePickerSection({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.allDay,
    required this.onDateChanged,
    required this.onTimeChanged,
    required this.onAllDayChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
          onPressed: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? today(),
              firstDate: DateTime(2025),
              lastDate: tenYear(),
            );
            onDateChanged(pickedDate);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.calendar_today_outlined),
              Text(selectedDate != null ? dateFormat(selectedDate) : 'Today'),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: allDay
              ? null
              : () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime ?? TimeOfDay.now(),
                  );
                  onTimeChanged(pickedTime);
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.alarm_outlined),
              Text(allDay ? 'all day' : timeFormat(selectedTime)),
              const Icon(Icons.keyboard_arrow_down_outlined),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'All day:',
                style: TextStyle(
                  color: allDay ? null : Theme.of(context).disabledColor,
                ),
              ),
              Switch(value: allDay, onChanged: onAllDayChanged),
            ],
          ),
        ),
      ],
    );
  }
}

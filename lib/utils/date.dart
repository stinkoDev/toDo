import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime today() {
  return DateTime.now().toLocal();
}

DateTime tenYear() {
  return DateTime(today().year + 10);
}

bool lateDueDate(DateTime? dueDate) {
  if (dueDate == null) return false;
  if (today() > dueDate) {}
  ;
}

String dateFormat(DateTime? inputDate) {
  if (inputDate == null) return 'No date';

  final now = DateTime.now().toLocal();
  final date = inputDate.toLocal();

  final dateOnly = DateTime(date.year, date.month, date.day);
  final nowOnly = DateTime(now.year, now.month, now.day);
  final diff = dateOnly.difference(nowOnly).inDays;

  return switch (diff) {
    0 => 'today',
    -1 => 'yesterday',
    1 => 'tomorrow',
    _ => DateFormat("dd/MM/yyyy").format(date),
  };
}

String dateTimeFormat(DateTime? inputDate) {
  if (inputDate == null) return 'No date';

  final now = DateTime.now().toLocal();
  final date = inputDate.toLocal();

  final dateOnly = DateTime(date.year, date.month, date.day);
  final nowOnly = DateTime(now.year, now.month, now.day);
  final diff = dateOnly.difference(nowOnly).inDays;

  return switch (diff) {
    0 => 'today at ${DateFormat("HH:mm").format(date)}',
    _ => DateFormat("dd/MM/yyyy 'at' HH:mm").format(date),
  };
}

String timeFormat(TimeOfDay? inputTime) {
  return inputTime.toString();
}

DateTime? fullDateTime(DateTime? inputDate, TimeOfDay? inputTime) {
  if (inputDate == null) return null;

  return DateTime(
    inputDate.year,
    inputDate.month,
    inputDate.day,
    inputTime?.hour ?? 0,
    inputTime?.minute ?? 0,
  );
}

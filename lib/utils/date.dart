import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime today() {
  return DateTime.now();
}

DateTime tenYear() {
  return DateTime(DateTime.now().year + 10);
}

String dateFormat(DateTime? inputDate) {
  if (inputDate == null) return 'No date';
  return DateFormat("dd/MM/yyyy").format(inputDate.toLocal());
}

String dateTimeFormat(DateTime? inputDate) {
  if (inputDate == null) return 'No date';
  return DateFormat("dd/MM/yyyy 'at' HH:mm").format(inputDate.toLocal());
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

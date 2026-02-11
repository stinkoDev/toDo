import 'package:flutter/material.dart';

DateTime today() {
  return DateTime.now();
}

DateTime tenYear() {
  return DateTime(DateTime.now().year + 10);
}

String dateFormat(DateTime? inputDate) {
  return inputDate.toString();
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

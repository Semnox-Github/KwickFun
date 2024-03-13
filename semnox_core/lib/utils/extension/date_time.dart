import 'package:flutter/material.dart';
import 'package:semnox_core/semnox_core.dart';

extension DateTimeFormat on DateTime {
  String formatToToday() {
    DateTime dateTime = DateFormat("MM-dd-yyyy").parse("$month-$day-$year");
    return convertDateTimeDisplay(dateTime.toString());
  }

  String formatWithTime() {
    return "${formatToToday()} - ${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}";
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd MMM yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  DateTime applied(TimeOfDay? time) {
    return DateTime(
        year, month, day, time?.hour ?? hour, time?.minute ?? minute);
  }
}

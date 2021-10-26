import 'package:flutter/material.dart';

extension DateTimeEx on DateTime {
  static DateTime nowWithoutTime() {
    final dateNow = DateTime.now().toUtc();
    return DateUtils.dateOnly(
      dateNow
    );
  }

  String toBrazilianDateString() {
    return "${toBrazilianDayMonthString()}/${this.year}";
  }

  String toBrazilianDayMonthString() {
    return "${_formatDateNumber(this.day)}/${_formatDateNumber(this.month)}";
  }

  String _formatDateNumber(int number) {
    if(number < 10) {
      return "0$number";
    }
    return number.toString();
  }
}
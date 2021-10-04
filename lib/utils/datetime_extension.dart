import 'package:flutter/material.dart';

extension DateTimeEx on DateTime {
  static nowWithoutTime() {
    final dateNow = DateTime.now().toUtc();
    return DateUtils.dateOnly(
      dateNow
    );
  }

  toBrazilianDateString() {
    return "${toBrazilianDayMonthString()}/${this.year}";
  }

  toBrazilianDayMonthString() {
    return "${_formatDateNumber(this.day)}/${_formatDateNumber(this.month)}";
  }

  _formatDateNumber(int number) {
    if(number < 10) {
      return "0$number";
    }
    return number;
  }
}
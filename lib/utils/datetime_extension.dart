import 'package:flutter/material.dart';

extension DateTimeEx on DateTime {
  static DateTime nowWithoutTime() {
    final dateNow = DateTime.now();
    return DateTime.utc(
      dateNow.year,
      dateNow.month,
      dateNow.day,
    );
  }

  String toBrazilianDateString() {
    return "${toBrazilianDayMonthString()}/${this.year}";
    // final date = toUtc();
    // return date._toBrazilianDateString();
  }

  // String _toBrazilianDateString() {
  // }

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
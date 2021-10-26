import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  final int maxDigits;
  double? _uMaskValue;
  CurrencyPtBrInputFormatter({required this.maxDigits});

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    _uMaskValue = value / 100;
    String newText = "R\$ " + formatNumber(_uMaskValue!);
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }

  static formatNumber(double value) {
    final formatter = new NumberFormat("#,##0.00", "pt_BR");
    return formatter.format(value);
  }

  double getUnmaskedDouble() {
    return _uMaskValue ?? 0;
  }
}
import 'package:intl/intl.dart';

String doubleToPtBrCurrency(double currency) {
  String formattedNumber = NumberFormat.currency(locale: "pt_BR", name: "").format(currency);
  return "R\$$formattedNumber";
}
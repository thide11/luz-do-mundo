import 'package:flutter/cupertino.dart';

void resetFocus(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
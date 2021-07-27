import 'package:flutter/material.dart';

abstract class Widgets {
  static scaffold(
    BuildContext context, {
    required String title,
    Widget? leading,
    List<Widget>? actions,
    bool colocarBotaoVoltar = true,
    double tamanhoBarra = 50,
    required Widget child,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: leading,
        actions: actions,
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }

  static _baseButton({required Widget child, required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: child,
      ),
    );
  }

  static button({required String text, required void Function() onTap}) {
    return Widgets._baseButton(
      child: Text(
        text,
      ),
      onTap: onTap,
    );
  }

  static buttonWithIcon({
    required String text,
    required IconData icon,
    required void Function() onTap,
  }) {
    return Widgets._baseButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

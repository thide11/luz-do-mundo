import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class TestScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  const TestScaffold({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context,
      title: title,
      child: child,
    );
  }
}

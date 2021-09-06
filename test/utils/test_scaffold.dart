import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/screen_util_init.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class TestScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  const TestScaffold({
    Key? key,
    this.title = "teste",
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return generateScreenUtilInit(
      child: MaterialApp(
        home: Widgets.scaffold(
          context,
          title: title,
          child: child,
        ),
      ),
    );
  }
}

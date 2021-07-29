import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luz_do_mundo/di/di.dart';
import 'package:luz_do_mundo/presentation/pages/home/home.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';

import 'presentation/theme/theme.dart';
import 'package:asuka/asuka.dart' as asuka;

void main() {
  loadDi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Luz do mundo',
      initialRoute: Routes.home,
      theme: theme,
      routes: Routes.getRoutes(),
      builder: asuka.builder,
      home: Home(),
    );
  }
}
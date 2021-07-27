import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/pages/home/home.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      title: 'Luz do mundo',
      initialRoute: Routes.home,
      routes: Routes.getRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black),
        ),
      ),
      home: Home(),
    );
  }
}

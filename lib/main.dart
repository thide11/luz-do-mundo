import 'package:asuka/asuka.dart' as asuka;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:luz_do_mundo/di/di.dart';
import 'package:luz_do_mundo/presentation/pages/home/home.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/screen_util_init.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'presentation/theme/theme.dart';

void main() {
  loadDi();
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return generateScreenUtilInit(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('pt')
        ],
        title: 'Luz do mundo',
        initialRoute: Routes.home,
        theme: theme,
        routes: Routes.getRoutes(),
        builder: asuka.builder,
        home: Home(),
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luz do mundo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black
          ),
          button: TextStyle(
            color: Colors.black
          )
        )
      ),
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              button(
                text: "Gestores",
                onTap: () {
                }
              ),
              buttonWithIcon(
                text: "Calendário",
                icon: Icons.calendar_today,
                onTap: () {
              
                }
              ),
            ],
          ),
        ),
      )
    );
  }

  button({ required String text, required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.amber,
        child: Text(
          text,
        ),
      ),
    );
  }

  buttonWithIcon({ required String text, required IconData icon, required void Function() onTap }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 10,),
            Text(
              text,
            )
          ],
        ),
      ),
    );
  }
}

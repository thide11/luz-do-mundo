import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class ShowCalendar extends StatelessWidget {
  const ShowCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: "Calendário", 
      child: Column(
        children: [
          Text("Nada aqui..")
        ],
      )
    );
  }
}
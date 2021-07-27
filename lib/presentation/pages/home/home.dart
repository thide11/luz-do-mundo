import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:luz_do_mundo/routes/routes.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context,
      title: "Home",
      child: Column(
        children: [
          Widgets.button(
            text: "Gestores",
            onTap: () => Navigator.pushNamed(context, Routes.listResponsibles),
          ),
          Widgets.buttonWithIcon(
            text: "Calendário",
            icon: Icons.calendar_today,
            onTap: () => Navigator.pushNamed(context, Routes.listPersons),
          ),
        ],
      ),
    );
  }
}

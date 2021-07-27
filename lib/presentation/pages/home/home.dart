import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:luz_do_mundo/routes/routes.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context,
      mostrarAppBar: false,
      title: "Home",
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 172,
            ),
            Text(
              "Luz do mundo",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 251,
            ),
            Widgets.button(
              text: "Calendário",
              onTap: () => Navigator.pushNamed(context, Routes.showCalendar),
            ),
            SizedBox(
              height: 33,
            ),
            Widgets.button(
              text: "Responsáveis",
              onTap: () => Navigator.pushNamed(context, Routes.listResponsibles),
            ),
            SizedBox(
              height: 33,
            ),
            Widgets.button(
              text: "Pessoas",
              onTap: () => Navigator.pushNamed(context, Routes.listPersons),
            ),
          ],
        ),
      ),
    );
  }
}

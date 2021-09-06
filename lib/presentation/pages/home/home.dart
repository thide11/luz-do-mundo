import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              height: 172.h,
            ),
            Text(
              "Luz do mundo",
              style: TextStyle(
                fontSize: 30.sp,
              ),
            ),
            SizedBox(
              height: 251.h,
            ),
            Widgets.button(
              text: "Calendário",
              onTap: () => Navigator.pushNamed(context, Routes.showCalendar),
            ),
            SizedBox(
              height: 33.h,
            ),
            Widgets.button(
              text: "Responsáveis",
              onTap: () => Navigator.pushNamed(context, Routes.listResponsibles),
            ),
            SizedBox(
              height: 33.h,
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

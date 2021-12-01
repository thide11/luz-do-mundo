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
              height: 120.h,
            ),
            Image.asset(
              "assets/images/logo.jpg",
              width: 300,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "LUZ DO MUNDO",
              style: TextStyle(
                fontSize: 34.sp,
                color: Colors.grey,
              ),
            ),
            Spacer(),
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
            SizedBox(
              height: 60.h,
            ),
          ],
        ),
      ),
    );
  }
}

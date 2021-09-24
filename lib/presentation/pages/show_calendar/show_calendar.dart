import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/theme/app_colors.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowCalendar extends StatelessWidget {
  const ShowCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context,
      title: "Calendário",
      child: Column(
        children: [
          _calendar(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 22.0.h),
            child: Text(
              "Ocorridos no dia ${"18/05"}",
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ),
          _addButton(
            text: "Adicionar plano",
            fontSize: 27.sp,
            onTap: () =>
                Navigator.pushNamed(context, Routes.showActionPlan),
          ),
          _addButton(
            text: "Adicionar acompanhamento",
            fontSize: 16.sp,
            backgroundColor: Color(0xFFFB2020).withOpacity(0.7),
            onTap: () =>
                Navigator.pushNamed(context, Routes.showAccompaniment),
          ),
        ],
      ),
    );
  }
  
  Widget _calendar() {
    return TableCalendar(
      locale: 'pt_BR',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: DateTime.now(),
      availableCalendarFormats: {CalendarFormat.month: ""},
      onDaySelected: (date, _) {
        print("Clicou em um data!");
      },
      calendarBuilders: CalendarBuilders(
        headerTitleBuilder: (context, date) {
          return Center(
            child: Text(
              DateFormat.yMMMM("pt_BR").format(date),
              style: TextStyle(
                fontSize: 20.sp,
              ),
            ),
          );
        },
        defaultBuilder: (context, data, _) {
          return Stack(
            children: [
              Positioned(
                right: 10,
                top: 13,
                child: Container(
                  width: 3.r,
                  height: 3.r,
                  color: Colors.yellow,
                ),
              ),
              Positioned(
                right: 16,
                top: 13,
                child: Container(
                  width: 3.r,
                  height: 3.r,
                  color: Colors.red,
                ),
              ),
              Center(child: Text(data.day.toString()))
            ],
          );
        },
      ),
    );
  }

  _addButton({
    required String text,
    required Function() onTap,
    Color? backgroundColor,
    required double fontSize,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 13.h, bottom: 22.h),
      child: Widgets.buttonWithIcon(
        text: text,
        icon: Icons.add_box,
        textStyle: TextStyle(
          fontSize: fontSize,
        ),
        backgroundColor: backgroundColor,
        onTap: onTap,
      ),
    );
  }
}

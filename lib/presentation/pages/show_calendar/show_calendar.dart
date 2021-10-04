import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injector/injector.dart';
import 'package:intl/intl.dart';
import 'package:luz_do_mundo/application/show_calendar/show_calendar_cubit.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/presentation/pages/show_calendar/show_calendar_body.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowCalendar extends StatelessWidget {
  const ShowCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Injector.appInstance.get<ShowCalendarCubit>()..load(),
      child: ShowCalendarBody(),
    );
  }
}

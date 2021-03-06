import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/show_calendar/filter/filter_cubit.dart';
import 'package:luz_do_mundo/application/show_calendar/show_calendar_cubit.dart';
import 'package:luz_do_mundo/presentation/pages/show_calendar/show_calendar_body.dart';

class ShowCalendar extends StatelessWidget {
  const ShowCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = ModalRoute.of(context)!.settings.arguments as FilterState?;
    return BlocProvider(
      create: (context) => Injector.appInstance.get<ShowCalendarCubit>()..loadWithFilter(filter),
      child: ShowCalendarBody(),
    );
  }
}

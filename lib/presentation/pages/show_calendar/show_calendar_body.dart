import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:luz_do_mundo/application/show_calendar/filter/filter_cubit.dart';
import 'package:luz_do_mundo/application/show_calendar/show_calendar_cubit.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';
import 'package:luz_do_mundo/presentation/pages/show_calendar/filter/filter_dialog.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/base-crud-wrapper.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowCalendarBody extends StatefulWidget {
  const ShowCalendarBody({Key? key}) : super(key: key);

  @override
  _ShowCalendarBodyState createState() => _ShowCalendarBodyState();
}

class _ShowCalendarBodyState extends State<ShowCalendarBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ShowCalendarCubit>();
    final state = cubit.state;

    return baseCrudWrapper<ShowCalendarState>(state, onLoaded: (data) {
      final showingAccompaiment = data.showingAccompaiment;
      final showingActionPlans = data.showingActionPlans;
      return Widgets.scaffold(
        context,
        title: "Calendário",
        actions: [
          IconButton(
            onPressed: () {
              showFilterDialog(data.filters);
            }, 
            icon: Icon(Icons.filter_list),
          )
        ],
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 26.h,),
              _filter(data.filters),
              _calendar(data),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 22.0.h),
                child: Text(
                  "Ocorridos no dia ${data.selectedDay.toBrazilianDayMonthString()}",
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              ),
              if(showingAccompaiment.length == 0 && showingActionPlans.length == 0)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 22.0.h),
                  child: Text(
                    "Nenhum registro encontrado",
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _activityCard(showingActionPlans[index]);
                },
                itemCount: showingActionPlans.length,
              ),
              if(DateTimeEx.nowWithoutTime().isBefore(data.selectedDay))
                _addButton(
                  text: "Adicionar plano",
                  fontSize: 27.sp,
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.createEditActivity,
                    arguments: Activity.empty(
                      ActivityType.ACTION_PLAN,
                      data.selectedDay,
                    ),
                  ),
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _activityCard(showingAccompaiment[index]);
                },
                itemCount: showingAccompaiment.length,
              ),
              if(DateTimeEx.nowWithoutTime().isAfter(data.selectedDay))
                _addButton(
                  text: "Adicionar acompanhamento",
                  fontSize: 16.sp,
                  backgroundColor: Color(0xFFFB2020).withOpacity(0.7),
                  onTap: () => Navigator.pushNamed(
                    context,
                    Routes.createEditActivity,
                    arguments: Activity.empty(
                      ActivityType.ACCOMPANIMENT,
                      data.selectedDay,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _filter(FilterState filters) {
    String text = "Adicionar filtros";
    if(filters.beneficiary != null && filters.responsible != null) {
      text = "2 filtros aplicados - Editar";
    } else if(filters.beneficiary != null || filters.responsible != null) {
      text = "1 filtro aplicado - Editar";
    }
    return GestureDetector(
      onTap: () {
        showFilterDialog(filters);
      },
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: Color(0xff0000EE),
        ),
      ),
    );
  }

  showFilterDialog(FilterState filters) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return FilterDialog(
          onApplyFilters: (filters) => context.read<ShowCalendarCubit>().onFilterChanged(filters),
          baseFilters: filters,
        );
      },
    );
  }

  Widget _calendar(ShowCalendarState state) {
    return TableCalendar(
      locale: 'pt_BR',
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      onPageChanged: (date) =>
          context.read<ShowCalendarCubit>().onMonthChanged(date),
      focusedDay: state.showingMonth,
      currentDay: state.selectedDay,
      availableCalendarFormats: {CalendarFormat.month: ""},
      onDaySelected: (date, _) =>
          context.read<ShowCalendarCubit>().onSelectedDayChanged(date),
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
          final haveActionsPlans = state.loadedActivities.any(
            (e) =>
                e.date!.isAtSameMomentAs(data) &&
                e.type == ActivityType.ACTION_PLAN,
          );
          final haveAccompanniment = state.loadedActivities.any(
            (e) =>
                e.date!.isAtSameMomentAs(data) &&
                e.type == ActivityType.ACCOMPANIMENT,
          );
          return Stack(
            children: [
              if (haveActionsPlans)
                Positioned(
                  right: 10,
                  top: 13,
                  child: Container(
                    width: 3.r,
                    height: 3.r,
                    color: Colors.yellow,
                  ),
                ),
              if (haveAccompanniment)
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

  Widget _activityCard(Activity activity) {
    late Color boxColor;
    late Color buttonsColor;
    late String title;
    if (activity.type == ActivityType.ACCOMPANIMENT) {
      boxColor = Color(0xFFFB2020).withOpacity(0.7);
      buttonsColor = Color(0xFFFF8484);
      title = "Acompanhamento";
    }
    if (activity.type == ActivityType.ACTION_PLAN) {
      boxColor = Color(0xFFFCE40E).withOpacity(0.8);
      buttonsColor = Color(0xFFEDFF7C);
      title = "Plano de ação";
    }

    return SizedBox(
      width: 341.w,
      child: Center(
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(Routes.showActivity, arguments: activity),
              child: Container(
                width: 341.w,
                padding: EdgeInsets.only(
                    right: 29.w, left: 29.w, top: 14.w, bottom: 16.w),
                decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: BorderRadius.all(Radius.circular(30.r))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      activity.title,
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    if (activity.beneficiary != null)
                      _activityCardRow(
                        "Beneficiário",
                        activity.beneficiary!,
                      ),
                    if (activity.responsible != null)
                      _activityCardRow(
                        "Responsável",
                        activity.responsible!,
                      ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 55.w,
            child: Container(
              decoration: BoxDecoration(
                color: buttonsColor,
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context)
                    .pushNamed(Routes.createEditActivity, arguments: activity),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: buttonsColor,
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => {
                  showDialog(
                    context: context, 
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: Text("Excluir atividade"),
                        content: Text("Deseja realmente excluir esta atividade?"),
                        actions: [
                          ElevatedButton(
                            child: Text("Cancelar"),
                            onPressed: () => Navigator.of(dialogContext).pop(),
                          ),
                          ElevatedButton(
                            child: Text("Excluir"),
                            onPressed: () {
                              context.read<ShowCalendarCubit>().onDeleteActivity(activity);
                              Navigator.of(dialogContext).pop();
                            },
                          ),
                        ],
                      );
                    }
                  )
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _activityCardRow(String label, BasePerson person) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Widgets.listImage(person.picture ?? AppFile.empty()),
          SizedBox(
            width: 13.w,
          ),
          Text(person.name)
        ],
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

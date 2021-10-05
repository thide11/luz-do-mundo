import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:luz_do_mundo/application/show_activity/show_activity_cubit.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/utils/double_to_pt_br_currency.dart';
import 'package:luz_do_mundo/presentation/widgets/base-crud-wrapper.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';

class ShowActivityBody extends StatelessWidget {
  const ShowActivityBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ShowActivityCubit>().state;

    return baseCrudWrapper<Activity>(state, onLoaded: (activity) {
      late String title;
      if (activity.type == ActivityType.ACCOMPANIMENT) {
        title = "Exibir acompanhamento";
      }
      if (activity.type == ActivityType.ACTION_PLAN) {
        title = "Exibir plano de ação";
      }
      return Widgets.scaffold(
        context,
        title: title,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(
              Routes.createEditActivity,
              arguments: activity,
            ),
            icon: Icon(Icons.edit),
          ),
        ],
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 28.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Widgets.labelAndValue("Titulo:", activity.title),
                Widgets.labelAndValue(
                    "Data:", activity.date!.toBrazilianDateString()),
                if (activity.type == ActivityType.ACCOMPANIMENT)
                  Widgets.labelAndValue(
                    "Valor gasto:",
                    doubleToPtBrCurrency(activity.amountSpend!),
                  ),
                Widgets.labelAndValue(
                    "Descrição:", activity.description ?? "Sem descrição"),
                Widgets.labelAndImage(
                  "Beneficiário:",
                  textIfNotFound: "Nenhum beneficiário atribuido",
                  name: "Solange",
                ),
                Widgets.labelAndImage(
                  "Responsável:",
                  textIfNotFound: "Nenhum responsável atribuido",
                  // name: "Solange",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

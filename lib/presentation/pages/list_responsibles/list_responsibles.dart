import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injector/injector.dart' as injector;
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/presentation/pages/list_responsibles/list_responsibles_body.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class ListResponsibles extends StatefulWidget {
  const ListResponsibles({Key? key}) : super(key: key);

  @override
  _ListResponsiblesState createState() => _ListResponsiblesState();
}

class _ListResponsiblesState extends State<ListResponsibles> {
  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(context,
        title: "Listar responsáveis",
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 23.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                BlocProvider<ListResponsiblesCubit>(
                  create: (_) =>
                      injector.Injector.appInstance.get<ListResponsiblesCubit>()
                        ..load(),
                  child: ListResponsiblesBody(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                GestureDetector(
                  child: Text(
                    "+ Adicionar responsável",
                    style: TextStyle(
                      fontSize: 23.sp,
                    ),
                  ),
                  onTap: () => Navigator.of(context)
                      .pushNamed(Routes.createEditResponsibles),
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/list_persons_cubit.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

import 'list_persons_body.dart';

class ListPersons extends StatefulWidget {
  const ListPersons({Key? key}) : super(key: key);

  @override
  _ListPersonsState createState() => _ListPersonsState();
}

class _ListPersonsState extends State<ListPersons> {
  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(context,
        title: "Listar pessoas carentes",
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 15),
                BlocProvider<ListPersonsCubit>(
                  create: (_) =>
                      Injector.appInstance.get<ListPersonsCubit>()..load(),
                  child: ListPersonsBody(),
                ),
                GestureDetector(
                  child: Text(
                    "+ Adicionar pessoas",
                    style: TextStyle(
                      fontSize: 23.sp,
                    ),
                  ),
                  onTap: () =>
                      Navigator.of(context).pushNamed(Routes.createEditPerson),
                ),
              ],
            ),
          ),
        ));
  }
}

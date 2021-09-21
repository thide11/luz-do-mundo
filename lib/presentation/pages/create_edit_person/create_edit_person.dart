import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';

import 'create_edit_person_body.dart';

class CreateEditPerson extends StatefulWidget {
  const CreateEditPerson({Key? key}) : super(key: key);

  static Widget title(String title) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }

  static Widget input({required String label, required String initialValue, required Function(String) onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  _CreateEditPersonState createState() => _CreateEditPersonState();
}

class _CreateEditPersonState extends State<CreateEditPerson> {
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final needyPerson = ModalRoute.of(context)!.settings.arguments as NeedyPerson?;
    return BlocProvider<CreateEditPersonCubit>(
      create: (context) => Injector.appInstance.get<CreateEditPersonCubit>()..load(needyPerson),
      child: CreateEditPersonBody(),
    );
  }
}

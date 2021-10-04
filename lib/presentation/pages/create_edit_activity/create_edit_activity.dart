import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/create_edit_action/create_edit_action_cubit.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_activity/create_edit_activity_body.dart';

class CreateEditActivity extends StatelessWidget {
  const CreateEditActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as Activity;
    return BlocProvider<CreateEditActionCubit>(
      create: (context) => CreateEditActionCubit(Injector.appInstance.get<ActivityRepository>(), activity),
      child: CreateEditActivityBody(),
    );
  }
}

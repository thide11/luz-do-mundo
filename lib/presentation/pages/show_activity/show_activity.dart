import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/show_activity/show_activity_cubit.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/repository/activity_repository.dart';
import 'package:luz_do_mundo/presentation/pages/show_activity/show_activity_body.dart';

class ShowActivity extends StatelessWidget {
  const ShowActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activity = ModalRoute.of(context)!.settings.arguments as Activity;
    return BlocProvider(
      create: (_) => ShowActivityCubit(Injector.appInstance.get<ActivityRepository>(), activity)..load(),
      child: ShowActivityBody(),
    );
  }
}

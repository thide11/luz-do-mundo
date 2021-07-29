import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_responsibles/create_edit_responsible_body.dart';

class CreateEditResponsibiles extends StatelessWidget {
  const CreateEditResponsibiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector.appInstance.get<CreateEditResponsiblesCubit>()..load(),
      child: CreateEditResponsibleBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/show_person/show_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/domain/repository/person_repository.dart';
import 'package:luz_do_mundo/presentation/pages/show_person/show_person_body.dart';

class ShowPerson extends StatelessWidget {
  const ShowPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final needyPerson =
        ModalRoute.of(context)!.settings.arguments as NeedyPerson;
    return BlocProvider(
      create: (context) => ShowPersonCubit(Injector.appInstance.get<PersonRepository>(), needyPerson)..load(),
      child: ShowPersonBody(
        needyPerson: needyPerson,
      ),
    );
  }
}

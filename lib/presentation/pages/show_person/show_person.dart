import 'package:flutter/material.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/presentation/pages/show_person/show_person_body.dart';

class ShowPerson extends StatelessWidget {
  const ShowPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final needyPerson =
        ModalRoute.of(context)!.settings.arguments as NeedyPerson;
    return ShowPersonBody(needyPerson: needyPerson,);
  }
}

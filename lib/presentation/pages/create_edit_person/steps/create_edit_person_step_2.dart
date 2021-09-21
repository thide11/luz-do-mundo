import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';

import '../create_edit_person.dart';

class CreateEditPersonStep2 extends StatelessWidget {
  const CreateEditPersonStep2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateEditPersonCubit>().getEditingStateOrNull();
    if(state == null) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreateEditPerson.title("Dados de contato"),
        CreateEditPerson.input(
          label: "Endereço :",
          initialValue: state.needyPerson.adress,
          onChanged: (text) => null,
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Telefone proprio :",
          initialValue: state.needyPerson.telephone,
          onChanged: (text) => null,
        ),
        Row(
          children: [
            Checkbox(
              value: true, 
              onChanged: (_) => null,
            ),
            Text("Possui telefone"),
          ],
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Nome da mãe :",
          initialValue: state.needyPerson.motherName,
          onChanged: (text) => null,
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Nome da pai :",
          initialValue: state.needyPerson.fatherName,
          onChanged: (text) => null,
        ),
        SizedBox(height: 16.h,),
      ],
    );
  }
}
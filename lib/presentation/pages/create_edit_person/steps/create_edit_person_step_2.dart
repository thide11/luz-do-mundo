import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../create_edit_person.dart';

class CreateEditPersonStep2 extends StatelessWidget {
  CreateEditPersonStep2({Key? key}) : super(key: key);
  final celphoneMask = new MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreateEditPersonCubit>();
    final state = cubit.getEditingStateOrNull();
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
          onChanged: (text) => cubit.onAdressChanged(text),
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Telefone proprio :",
          initialValue: state.needyPerson.telephone ?? "",
          onChanged: (text) => cubit.onTelephoneChanged(text),
          inputFormatters: [celphoneMask],
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Nome da mãe :",
          initialValue: state.needyPerson.motherName,
          onChanged: (text) => cubit.onMotherNameChanged(text),
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Nome da pai :",
          initialValue: state.needyPerson.fatherName,
          onChanged: (text) => cubit.onFatherNameChanged(text),
        ),
        SizedBox(height: 16.h,),
      ],
    );
  }
}
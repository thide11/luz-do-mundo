import 'package:flutter/material.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/widgets/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../create_edit_person.dart';

class CreateEditPersonStep1 extends StatelessWidget {
  const CreateEditPersonStep1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateEditPersonCubit>().getEditingStateOrNull();
    if(state == null) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreateEditPerson.title("Dados principais"),
        CreateEditPerson.input(
          label: "Nome :",
          initialValue: state.needyPerson.name,
          onChanged: (text) => null,
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Data de nascimento :",
          initialValue: state.needyPerson.birthDate.toIso8601String(),
          onChanged: (text) => null,
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Cpf :",
          initialValue: state.needyPerson.cpf,
          onChanged: (text) => null,
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Rg :",
          initialValue: state.needyPerson.rg,
          onChanged: (text) => null,
        ),
        SizedBox(height: 16.h,),
        ImagePicker(file: AppFile.empty(), onChanged: (_) => null),
      ],
    );
  }
}
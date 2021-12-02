import 'package:flutter/material.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/widgets/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../create_edit_person.dart';

class CreateEditPersonStep1 extends StatelessWidget {
  CreateEditPersonStep1({Key? key}) : super(key: key);
  final maskFormatter = new MaskTextInputFormatter(mask: '###.###.###-##', filter: { "#": RegExp(r'[0-9]') });

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
        CreateEditPerson.title("Dados principais"),
        CreateEditPerson.input(
          label: "Nome :",
          initialValue: state.needyPerson.name,
          onChanged: (text) => cubit.onNameChanged(text),
        ),
        SizedBox(height: 16.h,),

        CreateEditPerson.datePicker(
          context: context,
          label: "Data de nascimento :",
          currentValue: state.needyPerson.birthDate,
          firstDate: DateTime.now().subtract(Duration(days: 365*100)),
          lastDate: DateTime.now().subtract(Duration(days: 365*5)),
          onChanged: (date) => cubit.onBirthDateChanged(date),
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Cpf :",
          initialValue: state.needyPerson.cpf,
          keyboardType: TextInputType.number,
          onChanged: (text) => cubit.onCpfChanged(text),
          inputFormatters: [
            maskFormatter,
          ]
        ),
        SizedBox(height: 16.h,),
        CreateEditPerson.input(
          label: "Rg :",
          keyboardType: TextInputType.number,
          initialValue: state.needyPerson.rg,
          onChanged: (text) => cubit.onRgChanged(text),
        ),
        SizedBox(height: 16.h,),
        ImagePicker(
          label: "Foto de perfil :",
          file: state.needyPerson.picture ?? AppFile.empty(), 
          onChanged: (photo) => cubit.onPhotoChanged(photo),
          shouldBeCircular: true,
        ),
      ],
    );
  }
}
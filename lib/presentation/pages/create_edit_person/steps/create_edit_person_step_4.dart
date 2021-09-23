import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/widgets/image_picker.dart';

import '../create_edit_person.dart';

class CreateEditPersonStep4 extends StatelessWidget {
  const CreateEditPersonStep4({Key? key}) : super(key: key);

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
        CreateEditPerson.title("Renda"),
        CreateEditPerson.input(
          label:  "Renda :",
          keyboardType: TextInputType.number,
          initialValue: state.needyPerson.adress,
          onChanged: (text) => cubit.onIncomeChanged(int.tryParse(text) ?? 0),
        ),
        SizedBox(height: 20.h,),
        ImagePicker(
          file: state.needyPerson.workCard ?? AppFile.empty(), 
          onChanged: (photo) => cubit.onWorkCardChanged(photo),
          shouldBeCircular: false,
        ),
      ],
    );
  }
}
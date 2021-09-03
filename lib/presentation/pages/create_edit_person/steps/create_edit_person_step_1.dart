import 'package:flutter/material.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/widgets/image_picker.dart';

import '../create_edit_person.dart';

class CreateEditPersonStep1 extends StatelessWidget {
  const CreateEditPersonStep1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreateEditPerson.title("Dados principais"),
        CreateEditPerson.input("Nome :"),
        SizedBox(height: 16,),
        CreateEditPerson.input("Data de nascimento :"),
        SizedBox(height: 16,),
        CreateEditPerson.input("Cpf :"),
        SizedBox(height: 16,),
        CreateEditPerson.input("Rg :"),
        SizedBox(height: 16,),
        ImagePicker(file: AppFile.empty(), onChanged: (_) => null),
      ],
    );
  }
}
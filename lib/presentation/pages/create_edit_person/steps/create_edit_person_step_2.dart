import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../create_edit_person.dart';

class CreateEditPersonStep2 extends StatelessWidget {
  const CreateEditPersonStep2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreateEditPerson.title("Dados de contato"),
        CreateEditPerson.input("Endereço :"),
        SizedBox(height: 16.h,),
        CreateEditPerson.input("Telefone proprio :"),
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
        CreateEditPerson.input("Nome da mãe :"),
        SizedBox(height: 16.h,),
        CreateEditPerson.input("Nome da pai :"),
        SizedBox(height: 16.h,),
      ],
    );
  }
}
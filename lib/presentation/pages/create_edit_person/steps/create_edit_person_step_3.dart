import 'package:flutter/material.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/widgets/image_picker.dart';

import '../create_edit_person.dart';

class CreateEditPersonStep3 extends StatelessWidget {
  const CreateEditPersonStep3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreateEditPerson.title("Dependentes"),
        _dependentBox(),
        SizedBox(height: 20,),
        _dependentBox(),
      ],
    );
  }

  _dependentBox() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            padding: EdgeInsets.all(17),
            width: 304,
            decoration: BoxDecoration(
              color: Color(0xFFC4C4C4),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dependentBoxText("Thiago"),
                _dependentBoxText("Idade: 24"),
                _dependentBoxText("RG: 213.502.634-34"),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 55,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF35D11C),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => null,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF35D11C),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => null,
            ),
          ),
        ),
      ],
    );
  }

  _dependentBoxText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18
      ),
    );
  }

  _dependentCrudBox() {

  }

}
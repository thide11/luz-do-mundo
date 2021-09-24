import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEditAccompaniment extends StatelessWidget {
  const CreateEditAccompaniment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isEditing = true;
    final containsDate = true;
    return Widgets.scaffold(
      context,
      title: "${isEditing ? "Editar" : "Cadastrar"} acompanhamento",
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Widgets.labelAndChild(
                "Titulo:",
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                  ),
                ),
              ),
              Widgets.labelAndChild(
                "Data:",
                Row(
                  children: [
                    Text("02/07/2000"),
                    SizedBox(
                      width: 10.w,
                    ),
                    SizedBox(
                      width: 208.w,
                      height: 40.h,
                      child: Widgets.buttonWithIcon(
                        text: "${containsDate ? "Alterar" : "Selecionar"} dia",
                        icon: Icons.calendar_today,
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            locale: Locale('pt'),
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now(),
                          );
                          // if (selectedDate != null) {
                          //   onChanged(selectedDate);
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Widgets.labelAndChild(
                "Valor gasto:",
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: "R\$ 0,00",
                  ),
                ),
              ),
              Widgets.labelAndChild(
                "Descreve seu acompanhamento:",
                TextFormField(
                  maxLines: 10,
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
              ),
              labelAndImageWithEdits(
                "Beneficiário:",
                textIfNotFound: 'Nenhum beneficiário atribuido',
                name: "Roberto",
                onEditClicked: () {},
                onRemoveClicked: () {},
              ),
              labelAndImageWithEdits(
                "Responsável:",
                textIfNotFound: 'Nenhum responsável atribuido',
                name: "Julio",
                onEditClicked: () {},
                onRemoveClicked: () {},
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: Widgets.button(
                  text: "Salvar",
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  labelAndImageWithEdits(String label,
      {AppFile? profileImg,
      String? name,
      required String textIfNotFound,
      Widget? extraData,
      required Function() onEditClicked,
      required Function() onRemoveClicked,
    }) {
    return Widgets.labelAndImage(label,
        textIfNotFound: textIfNotFound,
        name: name,
        profileImg: profileImg,
        extraData: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
            ),
          ],
        )
        // extraData:
        );
  }
}

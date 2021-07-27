import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class CreateEditResponsibiles extends StatelessWidget {
  const CreateEditResponsibiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context,
      title: false ? "Editar responsável" : "Criar responsável",
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome :"),
            TextField(),
            SizedBox(
              height: 20,
            ),
            Text("Insira uma foto :"),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff224E00),
                borderRadius: BorderRadius.all(Radius.circular(100))
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Icon(Icons.picture_as_pdf, color: Colors.white,)
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Widgets.button(
                text: "Salvar",
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

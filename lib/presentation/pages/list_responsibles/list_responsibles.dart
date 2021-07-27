import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class ListResponsibles extends StatelessWidget {
  const ListResponsibles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: "Listar responsáveis", 
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 23,
          vertical: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => generateResponsibleItem(), 
              separatorBuilder: (context, index) => SizedBox(height: 25,), 
              itemCount: 2
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(Routes.createEditResponsibles),
              child: Text(
                "+ Adicionar responsável",
                style: TextStyle(
                  fontSize: 23,
                ),
              )
            )
          ],
        ),
      )
    );
  }

  generateResponsibleItem() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          color: Colors.black,
        ),
        SizedBox(
          width: 12,
        ),
        Text("Nome"),
        Spacer(),
        IconButton(
          onPressed: () => null,
          icon: Icon(Icons.edit),
        )
      ],
    );
  }
}

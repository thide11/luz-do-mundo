import 'package:flutter/cupertino.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:luz_do_mundo/routes/routes.dart';

class ListResponsibles extends StatelessWidget {
  const ListResponsibles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: "Listar responsáveis", 
      child: Center(
        child: Column(
          children: [
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
}

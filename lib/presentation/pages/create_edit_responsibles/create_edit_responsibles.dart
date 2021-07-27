import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class CreateEditResponsibiles extends StatelessWidget {
  const CreateEditResponsibiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: false ? "Editar responsável" : "Criar responsável",
      child: Text(""),
    );
  }
}
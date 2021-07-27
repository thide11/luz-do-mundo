import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class ListPersons extends StatelessWidget {
  const ListPersons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: "Listar pessoas carentes", 
      child: Text("Nada aqui...")
    );
  }
}
import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class CreateEditPerson extends StatelessWidget {
  const CreateEditPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: "Cadastrar pessoa", 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 23,
          ),
          _stepsBar(),
          SizedBox(
            height: 580,
            child: PageView(
              children: [
                Text("Dados principais"),
                Text("Dados de contato"),
                Text("Dependentes"),
                Text("Renda"),
              ],
            ),
          )
        ],
      )
    );
  }

  _stepsBar() {
    return Center(
      child: SizedBox(
        width: 280,
        child: Row(
          children: [
            _stepBall(
              selected: false,
              value: "1"
            ),
            _seperatorStepBall(),
            _stepBall(
              selected: false,
              value: "2"
            ),
            _seperatorStepBall(),
            _stepBall(
              selected: true,
              value: "3"
            ),
            _seperatorStepBall(),
            _stepBall(
              selected: false,
              value: "4"
            ),
          ],
        ),
      ),
    );
  }

  _seperatorStepBall() {
    return Expanded(
      child: Container(
        height: 1,
        color: Colors.black,
      )
    );
  }

  _stepBall({required String value, required bool selected}) {
    return Container(
      width: 37,
      height: 37,
      decoration: BoxDecoration(
        color: !selected ? Color(0xFFC4C4C4) : Color(0xFF76CD58),
        borderRadius: BorderRadius.all(Radius.circular(37)),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(0, 2),
            spreadRadius: 3,
            color: Colors.black.withOpacity(0.25),
          )
        ]
      ),
      child: Center(
        child: Text(
          value,
          style: TextStyle(
            fontSize: 18,
          ),
        )
      ),
    );
  }
}
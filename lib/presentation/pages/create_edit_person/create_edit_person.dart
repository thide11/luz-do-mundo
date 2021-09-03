import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/create_edit_person_step_1.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/create_edit_person_step_2.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/create_edit_person_step_3.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class CreateEditPerson extends StatefulWidget {
  const CreateEditPerson({Key? key}) : super(key: key);

  static Widget title(String title) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  static Widget input(String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(),
      ],
    );
  }

  @override
  _CreateEditPersonState createState() => _CreateEditPersonState();
}

class _CreateEditPersonState extends State<CreateEditPerson> {
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(context,
        title: "Cadastrar pessoa",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 23,
            ),
            _stepsBar(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 23),
              height: 550,
              child: PageView(
                controller: pageController,
                children: [
                  _pageViewElement(
                    CreateEditPersonStep1(),
                  ),
                  _pageViewElement(
                    CreateEditPersonStep2(),
                  ),
                  _pageViewElement(
                    CreateEditPersonStep3(),
                  ),
                  _pageViewElement(
                    Text("Renda"),
                  ),
                ],
                onPageChanged: (_) {
                  setState(() {});
                },
              ),
            ),
            Container(
              height: 56,
              width: 284,
              decoration: BoxDecoration(
                color: Color(0xFFFFED48),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  "Prosseguir ->" ?? "Salvar",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
            )
            // ElevatedButton(
            //   onPressed: () {
            //     print(pageController.page);
            //     pageController.nextPage(
            //         duration: Duration(milliseconds: 200),
            //         curve: Curves.easeInOut);
            //     setState(() {});
            //   },

            //   child: Text(
            //     "Prosseguir ->" ?? "Salvar",
            //   ),
            // ),
          ],
        ));
  }

  Widget _pageViewElement(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: child,
    );
  }

  _stepsBar() {
    final currentPage = pageController.hasClients
        ? pageController.page!.round()
        : 0; // positions.length > 0 ? pageController?.page?.floor() : 0;
    print(currentPage);
    return Center(
      child: SizedBox(
        width: 280,
        child: Row(
          children: [
            _stepBall(selected: 0 == currentPage, value: "1"),
            _seperatorStepBall(),
            _stepBall(selected: 1 == currentPage, value: "2"),
            _seperatorStepBall(),
            _stepBall(selected: 2 == currentPage, value: "3"),
            _seperatorStepBall(),
            _stepBall(selected: 3 == currentPage, value: "4"),
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
    ));
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
          ]),
      child: Center(
          child: Text(
        value,
        style: TextStyle(
          fontSize: 18,
        ),
      )),
    );
  }
}

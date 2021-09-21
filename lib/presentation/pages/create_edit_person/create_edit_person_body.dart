import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/create_edit_person_step_1.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/create_edit_person_step_2.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/create_edit_person_step_3.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/create_edit_person_step_4.dart';
import 'package:luz_do_mundo/presentation/pages/create_edit_person/steps/step_bar.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:asuka/asuka.dart' as asuka;

class CreateEditPersonBody extends StatelessWidget {
  CreateEditPersonBody({Key? key}) : super(key: key);

  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateEditPersonCubit, CreateEditPersonState>(
      listener: (context, state) {
        if (state is EditingCreateEditPerson) {
          pageController.animateToPage(
            state.currentPage,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
        if (state is SucessCreateEditPerson) {
          asuka.showSnackBar(
            SnackBar(
              content: Text("Pessoa salva com sucesso!"),
            )
          );
          return Navigator.of(context).pop();
        }
      },
      child: Widgets.scaffold(
        context,
        title: 
          "${context.read<CreateEditPersonCubit>().getEditingStateOrNull()!.needyPerson.id == null ? "Cadastrar" : "Editar"} pessoa",
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 23.h,
              ),
              StepBar(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 23.h),
                height: 550.h,
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
                      CreateEditPersonStep4(),
                    ),
                  ],
                  onPageChanged: (page) {
                    context.read<CreateEditPersonCubit>().setPage(page);
                  },
                ),
              ),
              GestureDetector(
                onTap: () => context.read<CreateEditPersonCubit>().forwardPage(),
                child: Container(
                  height: 56.h,
                  width: 284.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFED48),
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                  ),
                  child: Center(
                    child:
                        BlocBuilder<CreateEditPersonCubit, CreateEditPersonState>(
                      builder: (context, state) {
                        if (state is EditingCreateEditPerson) {
                          return Text(
                            state.currentPage != 3 ? "Prosseguir ->" : "Salvar",
                            style: TextStyle(
                              fontSize: 24.sp,
                            ),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _pageViewElement(Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: child,
    );
  }
}

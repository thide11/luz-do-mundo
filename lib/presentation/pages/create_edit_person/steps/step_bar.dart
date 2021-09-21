import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepBar extends StatefulWidget {
  const StepBar({Key? key}) : super(key: key);

  @override
  _StepBarState createState() => _StepBarState();
}

class _StepBarState extends State<StepBar> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreateEditPersonCubit>();
    final state = cubit.state;
    if(state is EditingCreateEditPerson) {
      final currentPage = state.currentPage;
      return _stepsBar(currentPage);
    }
    return Container();
  }

  _stepsBar(int currentPage) {
    return Center(
      child: SizedBox(
        width: 280.w,
        child: Row(
          children: [
            _stepBall(currentPage: currentPage, value: "1"),
            _seperatorStepBall(),
            _stepBall(currentPage: currentPage, value: "2"),
            _seperatorStepBall(),
            _stepBall(currentPage: currentPage, value: "3"),
            _seperatorStepBall(),
            _stepBall(currentPage: currentPage, value: "4"),
          ],
        ),
      ),
    );
  }

  _seperatorStepBall() {
    return Expanded(
      child: Container(
        height: 1.h,
        color: Colors.black,
      ),
    );
  }

  _stepBall({required String value, required int currentPage}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.read<CreateEditPersonCubit>().setPageAndLock((int.parse(value)-1));
      },
      child: Container(
        width: 37.r,
        height: 37.r,
        decoration: BoxDecoration(
            color: !(value == (currentPage+1).toString()) ? Color(0xFFC4C4C4) : Color(0xFF76CD58),
            borderRadius: BorderRadius.all(Radius.circular(37)),
            boxShadow: [
              BoxShadow(
                blurRadius: 5.r,
                offset: Offset(0, 2.w),
                spreadRadius: 3,
                color: Colors.black.withOpacity(0.25),
              )
            ]),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
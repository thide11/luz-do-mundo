import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/dependent.dart';

class CreateEditPersonStep3 extends StatelessWidget {
  const CreateEditPersonStep3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreateEditPersonCubit>();
    final state = cubit.getEditingStateOrNull();
    if(state == null) {
      return Container();
    }
    final isEditing = false;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final dependent = state.needyPerson.dependents[index];
        return _dependentBox(dependent) ?? _dependentCrudBox(dependent);
      }, 
      separatorBuilder: (context, index) => SizedBox(height: 20.h,),
      itemCount: state.needyPerson.dependents.length
    );
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     CreateEditPerson.title("Dependentes"),
    //     _dependentBox(),
    //     SizedBox(height: 20.h,),
    //     _dependentBox(),
    //     SizedBox(height: 20.h,),
    //     isEditing ? _dependentCrudBox() : _dependentBox(),
    //   ],
    // );
  }

  _dependentBox(Dependent dependent) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Container(
            padding: EdgeInsets.all(17.r),
            width: 304.w,
            decoration: BoxDecoration(
              color: Color(0xFFC4C4C4),
              borderRadius: BorderRadius.all(Radius.circular(10.r)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dependentBoxText(dependent.name),
                _dependentBoxText("Idade: ${dependent.age}"),
                _dependentBoxText("RG: ${dependent.rg}"),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 55.w,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF35D11C),
              borderRadius: BorderRadius.all(Radius.circular(30.r)),
            ),
            child: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => null,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF35D11C),
              borderRadius: BorderRadius.all(Radius.circular(30.r)),
            ),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => null,
            ),
          ),
        ),
      ],
    );
  }

  _dependentBoxText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18.sp
      ),
    );
  }

  Widget _dependentCrudBox(Dependent dependent) {
    return Container();
  }

}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/application/create_edit_person/dependents_manager/dependents_manager_cubit.dart';
import 'package:luz_do_mundo/domain/entity/dependent.dart';

import '../create_edit_person.dart';

class CreateEditPersonStep3 extends StatefulWidget {
  const CreateEditPersonStep3({Key? key}) : super(key: key);

  @override
  _CreateEditPersonStep3State createState() => _CreateEditPersonStep3State();
}

class _CreateEditPersonStep3State extends State<CreateEditPersonStep3> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateEditPersonCubit>();
    final state = cubit.getEditingStateOrNull();
    if (state == null) {
      return Container();
    }
    return BlocProvider(
      create: (_) => DependentsManagerCubit(cubit,
          dependents: state.needyPerson.dependents),
      child: CreateEditPersonStep3Body(),
    );
    // final dependents = state.needyPerson.dependents;

    // Column(
    // crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    // CreateEditPerson.title("Dependentes"),
    //     _dependentBox(),
    //     SizedBox(height: 20.h,),
    //     _dependentBox(),
    //     SizedBox(height: 20.h,),
    //     isEditing ? _dependentCrudBox() : _dependentBox(),
    //   ],
    // );
  }
}

class CreateEditPersonStep3Body extends StatefulWidget {
  @override
  _CreateEditPersonStep3BodyState createState() =>
      _CreateEditPersonStep3BodyState();
}

class _CreateEditPersonStep3BodyState extends State<CreateEditPersonStep3Body> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DependentsManagerCubit>();
    final state = cubit.state;
    final dependents = state.dependents;
    //cubit.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreateEditPerson.title("Dependentes"),
        Column(
          children: [
            if(dependents.length == 0)
              Center(child: Text("Nenhum dependente cadastrado")),
            SizedBox(
                  height: 430.h,
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (state.dependents.length == index) {
                        if(state.dependentEditingDraft != null) {
                          return Container();
                        }
                        return _addDependent();
                      }
                      final dependent = state.dependents[index];
                      return state.dependentEditingIndex != index
                          ? _dependentBox(index, dependent)
                          : _dependentCrudBox(state.dependentEditingDraft!);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                    itemCount: state.dependents.length + 1,
                  ),
                ),

          ],
        ),
      ],
    );
  }

  Widget _addDependent() {
    return Padding(
      padding: EdgeInsets.only(top: 23.h, bottom: 10.h),
      child: GestureDetector(
        onTap: () {
          context.read<DependentsManagerCubit>().onAdd();
        },
        child: Center(
          child: Text(
            "Adicionar dependente +",
            style: TextStyle(
              color: Color(0xFF0000FF),
              fontSize: 18.sp,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dependentBoxContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(17.r),
      width: 304.w,
      decoration: BoxDecoration(
        color: Color(0xFFC4C4C4),
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: child,
    );
  }

  Widget _dependentBox(int index, Dependent dependent) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: _dependentBoxContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dependentBoxText(dependent.name),
                _dependentBoxText("Idade: ${dependent.age ?? "Não informado"}"),
                _dependentBoxText("RG: ${dependent.rg  ?? "Não informado"}"),
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
              onPressed: () =>
                  context.read<DependentsManagerCubit>().onStartEdit(index),
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
              onPressed: () =>
                  context.read<DependentsManagerCubit>().onDelete(index),
            ),
          ),
        ),
      ],
    );
  }

  _dependentBoxText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.sp),
    );
  }

  Widget _dependentCrudBox(Dependent dependent) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: _dependentBoxContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _dependendCrudBoxInput(
                  hintText: "Digite o nome",
                  initialValue: dependent.name,
                  onChanged: (name) => context
                      .read<DependentsManagerCubit>()
                      .onNameChanged(name),
                ),
                _dependendCrudBoxInput(
                  hintText: "Digite a idade",
                  textInputType: TextInputType.number,
                  initialValue: dependent.age ?? "",
                  onChanged: (name) =>
                      context.read<DependentsManagerCubit>().onAgeChanged(name),
                ),
                _dependendCrudBoxInput(
                  hintText: "Digite o RG",
                  textInputType: TextInputType.number,
                  initialValue: dependent.rg ?? "",
                  onChanged: (name) =>
                      context.read<DependentsManagerCubit>().onRgChanged(name),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 55.w,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF35D11C),
              borderRadius: BorderRadius.all(Radius.circular(30.r)),
            ),
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () =>
                  context.read<DependentsManagerCubit>().onCancelEditing(),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF35D11C),
              borderRadius: BorderRadius.all(Radius.circular(30.r)),
            ),
            child: IconButton(
              icon: Icon(Icons.save),
              onPressed: () => context.read<DependentsManagerCubit>().onSave(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dependendCrudBoxInput({
    required String hintText,
    required String initialValue,
    TextInputType? textInputType,
    required Function(String) onChanged,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
      ),
      keyboardType: textInputType,
      initialValue: initialValue,
      onChanged: onChanged,
    );
  }
}

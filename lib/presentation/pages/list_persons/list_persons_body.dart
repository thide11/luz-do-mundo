import 'package:flutter/material.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/application/list_persons_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/presentation/utils/reset_focus.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class ListPersonsBody extends StatefulWidget {
  const ListPersonsBody({Key? key}) : super(key: key);

  @override
  _ListPersonsBodyState createState() => _ListPersonsBodyState();
}

class _ListPersonsBodyState extends State<ListPersonsBody> {
  @override
  Widget build(BuildContext context) {
    final data = context.watch<ListPersonsCubit>();
    final state = data.state;
    if (state is LoadingBaseCrudStates) {
      return Center(child: CircularProgressIndicator());
    }
    if (state is EmptyBaseCrudStates) {
      return Container();
    }
    if (state is ErrorBaseCrudStates) {
      print((state as ErrorBaseCrudStates).message);
      return Text("Ocorreu um erro :(");
    }
    if (state is LoadedBaseCrudStates) {
      final data = (state as LoadedBaseCrudStates<List<NeedyPerson>>).data;
      return Column(
        children: [
          _generateFilterForm(),
          _listPersons(data),
        ],
      );
    }
    return Text("Estado desconhecido!");
  }

  Widget _generateFilterForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              width: 200.w,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Filtrar pessoas...",
                  border: InputBorder.none,
                ),
                autofocus: false,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.44), fontSize: 18.sp),
                onChanged: (filter) => context.read<ListPersonsCubit>().onFilterChanged(filter),
              ),
            ),
            Container(
              width: 200.w,
              height: 1.h,
              color: Colors.black,
            )
          ],
        ),
        Icon(Icons.search)
      ],
    );
  }

  Widget _listPersons(List<NeedyPerson> data) {
    if(data.isEmpty) {
      return Center(child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0.h),
        
        child: Text("Nenhuma pessoa encontrada"),
      ));
    }
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: 33.w,
        vertical: 30.h,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _generatePersonListItem(data[index]),
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
        ),
        child: Center(child: Container(height: 1.h, width: 270.w, color: Color(0xFFFCE40E),))
      ), 
      itemCount: data.length,
    );
  }

  Widget _generatePersonListItem(NeedyPerson person) {
    return GestureDetector(
      onTap: () {
        resetFocus(context);
        Navigator.pushNamed(context, Routes.showPerson, arguments: person);
      },
      child: Row(
        children: [
          Widgets.listImage(person.picture ?? AppFile.empty()),
          SizedBox(
            width: 10.w,
          ),
          Text(
            person.name,
            style: TextStyle(
              fontSize: 18.sp,
            ),
          )
        ],
      ),
    );
  }
}
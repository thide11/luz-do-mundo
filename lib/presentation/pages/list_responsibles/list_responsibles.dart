import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injector/injector.dart' as injector;
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class ListResponsibles extends StatefulWidget {
  const ListResponsibles({Key? key}) : super(key: key);

  @override
  _ListResponsiblesState createState() => _ListResponsiblesState();
}

class _ListResponsiblesState extends State<ListResponsibles> {
  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: "Listar responsáveis", 
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 23.w,
            vertical: 10.h,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              BlocProvider<ListResponsiblesCubit>(
                create: (_) => injector.Injector.appInstance.get<ListResponsiblesCubit>()..load(),
                child: Builder(
                  builder: (context) {
                    final data = context.watch<ListResponsiblesCubit>();
                    final state = data.state;
                    if(state is LoadingBaseCrudStates) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if(state is EmptyBaseCrudStates) {
                      return Container();
                    }
                    if(state is ErrorBaseCrudStates) {
                      print((state as ErrorBaseCrudStates).message);
                      return Text("Ocorreu um erro :(");
                    }
                    if(state is LoadedBaseCrudStates) {
                      final data = (state as LoadedBaseCrudStates<List<Responsible>>).data;
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => generateResponsibleItem(data[index]),
                        separatorBuilder: (context, index) => SizedBox(height: 25.h,), 
                        itemCount: data.length
                      );
                    } 
                    return Text("Estado desconhecido!");
                  }
                ) 
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                child: Text(
                  "+ Adicionar responsável",
                  style: TextStyle(
                    fontSize: 23.sp,
                  ),
                ),
                onTap: () => Navigator.of(context).pushNamed(Routes.createEditResponsibles),
              )
            ],
          ),
        ),
      )
    );
  }

  generateResponsibleItem(Responsible responsible) {
    return Row(
      children: [
        SizedBox(
          width: 48.r,
          height: 48.r,
          child: 
          responsible.picture != null ?
          Widgets.listImage(responsible.picture!)
          :
          Container(
            color: Colors.black,
          )
        ),
        SizedBox(
          width: 12.w,
        ),
        Text(
          responsible.name,
          style: TextStyle(
            fontSize: 20.sp,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () => Navigator.of(context).pushNamed(
            Routes.createEditResponsibles,
            arguments: responsible
          ),
          icon: Icon(Icons.edit),
        )
      ],
    );
  }
}

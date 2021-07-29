import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/core/base_crud_states.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/entity/responsible.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:injector/injector.dart' as injector;

class ListResponsibles extends StatelessWidget {
  const ListResponsibles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: "Listar responsáveis", 
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 10,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              BlocProvider<ListResponsiblesCubit>(
                create: (_) => injector.Injector.appInstance.get<ListResponsiblesCubit>()..load(),
                child: Builder(
                  builder: (context) {
                    final data = context.watch<ListResponsiblesCubit>();
                    final state = data.state;
                    if(state is LoadingBaseCrudStates) {
                      return CircularProgressIndicator();
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
                        separatorBuilder: (context, index) => SizedBox(height: 25,), 
                        itemCount: data.length
                      );
                    } 
                    return Text("Estado desconhecido!");
                  }
                ) 
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(Routes.createEditResponsibles),
                child: Text(
                  "+ Adicionar responsável",
                  style: TextStyle(
                    fontSize: 23,
                  ),
                )
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
        Container(
          width: 48,
          height: 48,
          color: Colors.black,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          responsible.name,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () => null,
          icon: Icon(Icons.edit),
        )
      ],
    );
  }
}

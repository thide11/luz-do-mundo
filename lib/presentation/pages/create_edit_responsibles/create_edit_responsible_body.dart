import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:asuka/asuka.dart' as asuka;

class CreateEditResponsibleBody extends StatelessWidget {
  const CreateEditResponsibleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditResponsiblesCubit,
        CreateEditResponsiblesState>(
      builder: (context, state) {
        if (state is EmptyCreateEditResponsibles) {
          return Text("Nada aqui..");
        }
        if (state is EditingCreateEditResponsibles)
          return Widgets.scaffold(
            context,
            title: false ? "Editar responsável" : "Criar responsável",
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nome :"),
                  TextField(
                    onChanged: (text) => context
                        .read<CreateEditResponsiblesCubit>()
                        .onNameChanged(text),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Insira uma foto :"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff224E00),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: state.isSaving ? CircularProgressIndicator() : Widgets.button(
                      text: "Salvar",
                      onTap: () {
                        context.read<CreateEditResponsiblesCubit>().save();
                      },
                    ),
                  )
                ],
              ),
            ),
          );

        return Container();
      },
      listener: (context, state) {
        if (state is SucessCreateEditResponsibles) {
          asuka.showSnackBar(
            SnackBar(
              content: Text("Responsável criado com sucesso!"),
            )
          );
          return Navigator.of(context).pop();
        }
      },
    );
  }
}

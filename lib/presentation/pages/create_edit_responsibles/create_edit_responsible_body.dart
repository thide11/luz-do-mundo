import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/create_edit_responsibles_cubit/create_edit_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/widgets/image_picker.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            title: state.isEditing ? "Editar responsável" : "Criar responsável",
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 20.h,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nome :"),
                  TextFormField(
                    initialValue: state.responsible.name,
                    onChanged: (text) => context
                        .read<CreateEditResponsiblesCubit>()
                        .onNameChanged(text),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ImagePicker(
                    file: state.responsible.picture ?? AppFile.empty(),
                    onChanged: (AppFile appFile) {
                      context.read<CreateEditResponsiblesCubit>().onPictureChanged(appFile);
                    },
                  ),
                  SizedBox(
                    height: 20.h,
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

        return Text("Tem parada errada ae mermão..");
      },
      listener: (context, state) {
        if (state is SucessCreateEditResponsibles) {
          asuka.showSnackBar(
            SnackBar(
              content: Text("Responsável salvo com sucesso!"),
            )
          );
          return Navigator.of(context).pop();
        }
      },
    );
  }
}

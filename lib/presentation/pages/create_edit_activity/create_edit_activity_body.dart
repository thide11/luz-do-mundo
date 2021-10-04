import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/application/create_edit_action/create_edit_action_cubit.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';
import 'package:asuka/asuka.dart' as asuka;

class CreateEditActivityBody extends StatelessWidget {
  const CreateEditActivityBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditActionCubit, CreateEditActionState>(
      listener: (context, state) {
        if(state.successfulSaved) {
          asuka.showSnackBar(
            SnackBar(
              content: Text("Atividade salva com sucesso!"),
            )
          );
          return Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreateEditActionCubit>();
        final activity = state.activity;
        final isEditing = activity.isEditing;
        String title = "${isEditing ? 'Editar' : 'Cadastrar'}";
        if (activity.type == ActivityType.ACTION_PLAN) {
          title += " plano de ação";
        }
        if (activity.type == ActivityType.ACCOMPANIMENT) {
          title += " acompanhamento";
        }
        return Widgets.scaffold(
          context,
          title: title,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 28.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Widgets.labelAndChild(
                    "Titulo:",
                    TextFormField(
                      decoration: InputDecoration(
                        isDense: true,
                      ),
                      initialValue: activity.title,
                      onChanged: (title) => cubit.onTitleChanged(title),
                    ),
                  ),
                  Widgets.labelAndChild(
                    "Data:",
                    Row(
                      children: [
                        Text(activity.date!.toBrazilianDateString()),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                          width: 208.w,
                          height: 40.h,
                          child: Widgets.buttonWithIcon(
                            text: "${activity.isEditing ? "Alterar" : "Selecionar"} dia",
                            icon: Icons.calendar_today,
                            onTap: () async {
                              final selectedDate = await showDatePicker(
                                locale: Locale('pt'),
                                context: context,
                                firstDate: activity.type == ActivityType.ACTION_PLAN ? activity.date! : DateTimeEx.nowWithoutTime().subtract(Duration(days: 365)),
                                initialDate: activity.date!,
                                lastDate: activity.type == ActivityType.ACTION_PLAN ? DateTimeEx.nowWithoutTime().add(Duration(days: 365)) : activity.date!,
                              );
                              if (selectedDate != null) {
                                cubit.onDateChanged(selectedDate);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(activity.type == ActivityType.ACCOMPANIMENT)
                    Widgets.labelAndChild(
                      "Valor gasto:",
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "R\$ 0,00",
                        ),
                        initialValue: activity.amountSpend.toString(),
                        onChanged: (value) => cubit.onAmountSpendChanged(value),
                      ),
                    ),
                  Widgets.labelAndChild(
                    "Descreve seu acompanhamento:",
                    TextFormField(
                      maxLines: 10,
                      initialValue: activity.description,
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                      onChanged: (description) => cubit.onDescriptionChanged(description),
                    ),
                  ),
                  labelAndImageWithEdits(
                    "Beneficiário:",
                    textIfNotFound: 'Nenhum beneficiário atribuido',
                    name: "Roberto",
                    onEditClicked: () {},
                    onRemoveClicked: () {},
                  ),
                  labelAndImageWithEdits(
                    "Responsável:",
                    textIfNotFound: 'Nenhum responsável atribuido',
                    name: "Julio",
                    onEditClicked: () {},
                    onRemoveClicked: () {},
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Widgets.button(
                      text: "Salvar",
                      isLoading: state.isSaving,
                      onTap: () => cubit.save(),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget labelAndImageWithEdits(
    String label, {
    AppFile? profileImg,
    String? name,
    required String textIfNotFound,
    Widget? extraData,
    required Function() onEditClicked,
    required Function() onRemoveClicked,
  }) {
    return Widgets.labelAndImage(
      label,
      textIfNotFound: textIfNotFound,
      name: name,
      profileImg: profileImg,
      extraData: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.close),
          ),
        ],
      ),
      // extraData:
    );
  }
}

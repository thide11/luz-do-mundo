import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/application/create_edit_action/create_edit_action_cubit.dart';
import 'package:luz_do_mundo/application/list_persons_cubit.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/presentation/utils/currency_pt_br_input_formatter.dart';
import 'package:luz_do_mundo/presentation/utils/double_to_pt_br_currency.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';

class CreateEditActivityBody extends StatefulWidget {
  CreateEditActivityBody({Key? key}) : super(key: key);

  @override
  _CreateEditActivityBodyState createState() => _CreateEditActivityBodyState();
}

class _CreateEditActivityBodyState extends State<CreateEditActivityBody> {
  final currencyFormatter = CurrencyPtBrInputFormatter(maxDigits: 20);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateEditActivityCubit, CreateEditActivityState>(
      listener: (context, state) {
        if (state.successfulSaved) {
          asuka.showSnackBar(SnackBar(
            content: Text("Atividade salva com sucesso!"),
          ));
          return Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final cubit = context.read<CreateEditActivityCubit>();
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
                            text:
                                "${activity.isEditing ? "Alterar" : "Selecionar"} dia",
                            icon: Icons.calendar_today,
                            onTap: () => showDatePickerSelector(activity),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (activity.type == ActivityType.ACCOMPANIMENT)
                    Widgets.labelAndChild(
                      "Valor gasto:",
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          currencyFormatter,
                        ],
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "R\$ 0,00",
                        ),
                        initialValue:
                            doubleToPtBrCurrency(activity.amountSpend!),
                        onChanged: (value) => cubit.onAmountSpendChanged(
                          currencyFormatter.getUnmaskedDouble(),
                        ),
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
                      onChanged: (description) =>
                          cubit.onDescriptionChanged(description),
                    ),
                  ),
                  Widgets.labelAndImageWithEdits(
                    "Beneficiário:",
                    textIfNotFound: 'Sem beneficiário',
                    person: state.activity.beneficiary,
                    onAddClicked: showBeneficiaryDialog,
                    onEditClicked: showBeneficiaryDialog,
                    onRemoveClicked: () {
                      cubit.onBeneficiaryChanged(null);
                    },
                  ),
                  Widgets.labelAndImageWithEdits(
                    "Responsável:",
                    textIfNotFound: 'Sem responsável',
                    person: state.activity.responsible,
                    onAddClicked: showResponsibleDialog,
                    onEditClicked: showResponsibleDialog,
                    onRemoveClicked: () {
                      cubit.onResponsibleChanged(null);
                    },
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

  void showBeneficiaryDialog() {
    Widgets.showCrudDialog<ListPersonsCubit>(
      context: context,
      onTap: (person) {
        context
          .read<CreateEditActivityCubit>()
          .onBeneficiaryChanged(person);
      },
      title: "Selecione um beneficiário",
    );
  }

  void showResponsibleDialog() {
    Widgets.showCrudDialog<ListResponsiblesCubit>(
      context: context,
      onTap: (person) {
        context
          .read<CreateEditActivityCubit>()
          .onResponsibleChanged(person);
      },
      title: "Selecione um responsável"
    );
  }

  void showDatePickerSelector(Activity activity) async {
    late DateTime firstDate;
    late DateTime initialDate;
    late DateTime lastDate;
    final currentDate = DateTimeEx.nowWithoutTime();
    final activityDate = activity.date!;
    if (activity.type == ActivityType.ACTION_PLAN) {
      firstDate = currentDate;
      initialDate =
          activityDate.isAfter(currentDate) ? activityDate : currentDate;
      lastDate = currentDate.add(
        Duration(days: 365),
      );
    }
    if (activity.type == ActivityType.ACCOMPANIMENT) {
      firstDate = DateTime.fromMillisecondsSinceEpoch(0);
      initialDate =
          activityDate.isAfter(currentDate) ? currentDate : activityDate;
      lastDate = currentDate;
    }
    final selectedDate = await showDatePicker(
      locale: Locale('pt'),
      context: context,
      firstDate: firstDate,
      initialDate: initialDate,
      lastDate: lastDate,
    );
    if (selectedDate != null) {
      context.read<CreateEditActivityCubit>().onDateChanged(selectedDate);
    }
  }
}

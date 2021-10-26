import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luz_do_mundo/application/list_persons_cubit.dart';
import 'package:luz_do_mundo/application/list_responsibles_cubit.dart';
import 'package:luz_do_mundo/application/show_calendar/filter/filter_cubit.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDialog extends StatelessWidget {
  final Function(FilterState) onApplyFilters;
  final FilterState baseFilters;
  FilterDialog({
    Key? key,
    required this.baseFilters,
    required this.onApplyFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilterCubit(baseFilters),
      child: Builder(
        builder: (context) {
          final cubit = context.watch<FilterCubit>();
          final state = cubit.state;
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              width: 296.w,
              height: 305.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Colors.white,
                    Color(0xffECECEC),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              child: Stack(
                children: [
                  Positioned(
                    right: 0.w,
                    top: 0.h,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 17.h,
                      ),
                      Text(
                        "Definir filtros",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 6.h,),
                      Container(
                        padding: EdgeInsets.only(bottom: 17.h),
                        height: 1.h,
                        width: 265.w,
                        color: Color(0xFF989898),
                      ),
                      SizedBox(height: 17.h),
                      Widgets.labelAndImageWithEdits(
                        "Por beneficiário:",
                        textIfNotFound: 'Selecionar..',
                        person: state.beneficiary,
                        onAddClicked: () => _showBeneficiarySelector(context),
                        onEditClicked: () => _showBeneficiarySelector(context),
                        onRemoveClicked: cubit.removeBeneficiary,
                      ),
                      Widgets.labelAndImageWithEdits(
                        "Por responsável:",
                        textIfNotFound: 'Selecionar..',
                        person: state.responsible,
                        onAddClicked: () => _showResponsibleSelector(context),
                        onEditClicked: () => _showResponsibleSelector(context),
                        onRemoveClicked: cubit.removeResponsible,
                      ),
                      Spacer(),
                      _buttons(context),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buttons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _button(
              context: context,
              onTap: () {
                context.read<FilterCubit>().clearFilters();
                Navigator.of(context).pop();
                onApplyFilters(context.read<FilterCubit>().state);
              },
              buttonText: "Remover filtros",
              style: TextStyle(fontSize: 12.sp)),
        ),
        SizedBox(
          width: 24.w,
        ),
        Expanded(
          child: _button(
            context: context,
            onTap: () {
              onApplyFilters(context.read<FilterCubit>().state);
              Navigator.of(context).pop();
            },
            buttonText: "Aplicar",
          ),
        ),
      ],
    );
  }

  Widget _button({
    required BuildContext context,
    required Function() onTap,
    required String buttonText,
    TextStyle? style,
  }) {
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFE3E4E8)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          shadowColor: MaterialStateProperty.all<Color>(Color(0xFFE3E4E8)),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ).merge(style),
        ),);
  }

  _showBeneficiarySelector(BuildContext context) {
    Widgets.showCrudDialog<ListPersonsCubit>(
      context: context,
      onTap: (beneficiary) {
        context.read<FilterCubit>().setBeneficiary(beneficiary);
      },
      title: "Selecione um beneficiário",
    );
  }

  _showResponsibleSelector(BuildContext context) {
    Widgets.showCrudDialog<ListResponsiblesCubit>(
      context: context,
      onTap: (beneficiary) {
        context.read<FilterCubit>().setResponsible(beneficiary);
      },
      title: "Selecione um responsável",
    );
  }
}

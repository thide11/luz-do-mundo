import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injector/injector.dart';
import 'package:luz_do_mundo/application/create_edit_person/create_edit_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';

import 'create_edit_person_body.dart';

class CreateEditPerson extends StatefulWidget {
  const CreateEditPerson({Key? key}) : super(key: key);

  static Widget title(String title) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }

  static Widget input(
      {required String label,
      required String initialValue,
      required Function(String) onChanged,
      TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }

  static Widget datePicker(
      {required BuildContext context,
      required String label,
      required DateTime currentValue,
      required Function(DateTime) onChanged,
      required DateTime lastDate,
      required DateTime firstDate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            Text(currentValue.toBrazilianDateString()),
            IconButton(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  locale: Locale('pt'),
                  context: context,
                  initialDate: currentValue,
                  firstDate: firstDate,
                  lastDate: DateTime(2030) // lastDate,
                );
                if (selectedDate != null) {
                  onChanged(selectedDate);
                }
              },
              icon: Icon(Icons.calendar_today),
            )
          ],
        ),
      ],
    );
  }

  @override
  _CreateEditPersonState createState() => _CreateEditPersonState();
}

class _CreateEditPersonState extends State<CreateEditPerson> {
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final needyPerson =
        ModalRoute.of(context)!.settings.arguments as NeedyPerson?;
    return BlocProvider<CreateEditPersonCubit>(
      create: (context) =>
          Injector.appInstance.get<CreateEditPersonCubit>()..load(needyPerson),
      child: CreateEditPersonBody(),
    );
  }
}

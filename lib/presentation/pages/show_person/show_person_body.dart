import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/application/show_calendar/filter/filter_cubit.dart';
import 'package:luz_do_mundo/application/show_person/show_person_cubit.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/app_file_to_image_provider.dart';
import 'package:luz_do_mundo/presentation/widgets/base-crud-wrapper.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowPersonBody extends StatelessWidget {
  final NeedyPerson needyPerson;
  const ShowPersonBody({required this.needyPerson, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ShowPersonCubit>();
    final state = cubit.state;

    return baseCrudWrapper<NeedyPerson>(state, onLoaded: (needyPerson) {
      return Widgets.scaffold(
        context,
        title: "Informações da pessoa",
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              Routes.createEditPerson,
              arguments: needyPerson,
            ),
            icon: Icon(Icons.edit),
          ),
        ],
        child: Padding(
          padding: EdgeInsets.fromLTRB(17.h, 33.h, 17.h, 90.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 163.r,
                  width: 163.r,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(82.0.r)),
                    border: Border.all(width: 1.w),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: appFileToImageProvider(needyPerson.picture),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              _text("Nome", needyPerson.name),
              SizedBox(
                height: 24.h,
              ),
              _text("Data de nascimento",
                  needyPerson.birthDate.toBrazilianDateString()),
              SizedBox(
                height: 24.h,
              ),
              _text("Endereço", needyPerson.adress),
              SizedBox(
                height: 24.h,
              ),
              _text("CPF", needyPerson.cpf),
              SizedBox(
                height: 24.h,
              ),
              _text("RG", needyPerson.rg),
              Spacer(),
              Center(
                child: Widgets.buttonWithIcon(
                  text: "Exibir datas",
                  icon: Icons.calendar_today,
                  textStyle: TextStyle(fontSize: 27.sp),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.showCalendar,
                      arguments: FilterState(beneficiary: needyPerson)
                    );
                  },
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Center(
                child: Widgets.buttonWithIcon(
                  text: "Exportar dados",
                  textStyle: TextStyle(fontSize: 27.sp),
                  icon: Icons.picture_as_pdf,
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _text(String atribute, String value) {
    return Text(
      "$atribute: ${value != "" ? value : "Não informado"}",
      style: TextStyle(
        fontSize: 18.sp,
      ),
    );
  }
}

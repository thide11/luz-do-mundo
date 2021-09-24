import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:luz_do_mundo/domain/entity/activity.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowAccompaniment extends StatelessWidget {
  const ShowAccompaniment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accompaniment = Activity(
      id: "",
      title: "Ajudar a léticia a amarrar as contas",
      description:
          "molestie auctor. Nam a placerat nunc. Mauris finibus porttitor tincidunt. Proin vel ligula et justo varius convallis eget nec magna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Etiam vel justo ullamcorper urna ullamcorper interdum sit amet in arcu. Aenean aliquet nisl neque, in cursus enim vestibulum a. Ut libero eros, accumsan eu dolor vitae, posuere faucibus orci. Donec in purus mi. Nunc arcu magna, lacinia vitae ante nec, ultrices placerat erat.",
      type: ActivityType.ACTION_PLAN,
      amountSpend: 20.50,
    );
    return Widgets.scaffold(
      context,
      title: "Acompanhamento",
      actions: [
        IconButton(
          onPressed: () =>
              Navigator.of(context).pushNamed(Routes.createEditAccompaniment),
          icon: Icon(Icons.edit),
        ),
      ],
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 23.h, horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Widgets.labelAndValue("Titulo:", accompaniment.title),
              Widgets.labelAndValue("Data:", "18/05/2021"),
              Widgets.labelAndValue("Valor gasto:",
                  "R\$ ${NumberFormat("###.00", "pt_BR").format(accompaniment.amountSpend)}"),
              Widgets.labelAndValue(
                  "Descrição:", accompaniment.description ?? "Sem descrição"),
              Widgets.labelAndImage(
                "Beneficiário:",
                textIfNotFound: "Nenhum beneficiário atribuido",
                name: "Solange",
              ),
              Widgets.labelAndImage(
                "Responsável:",
                textIfNotFound: "Nenhum responsável atribuido",
                // name: "Solange",
              ),
              // _labelAndValue("Responsável", value)
              // Text("Titulo:")
              // Text(accompaniment.title),
            ],
          ),
        ),
      ),
    );
  }
}

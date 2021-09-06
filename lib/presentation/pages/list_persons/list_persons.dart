import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/routes/routes.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListPersons extends StatefulWidget {
  const ListPersons({Key? key}) : super(key: key);

  @override
  _ListPersonsState createState() => _ListPersonsState();
}

class _ListPersonsState extends State<ListPersons> {
  @override
  Widget build(BuildContext context) {
    return Widgets.scaffold(
      context, 
      title: "Listar pessoas carentes", 
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 15
              ),
              _generateFilterForm(),
              _listPersons(),
              GestureDetector(
                child: Text(
                  "+ Adicionar pessoas",
                  style: TextStyle(
                    fontSize: 23.sp,
                  ),
                ),
                onTap: () => Navigator.of(context).pushNamed(Routes.createEditPerson),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _generateFilterForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              width: 200.w,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Filtrar pessoas...",
                  border: InputBorder.none
                ),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.44),
                  fontSize: 18.sp
                ),
                onChanged: (_) => null,
              ),
            ),
            Container(
              width: 200.w,
              height: 1.h,
              color: Colors.black,
            )
          ],
        ),
        Icon(Icons.search)
      ],
    );
  }

  Widget _listPersons() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        horizontal: 33.w,
        vertical: 30.h,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _generatePersonListElement(),
      separatorBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          vertical: 14.h,
        ),
        child: Center(child: Container(height: 1.h, width: 270.w, color: Color(0xFFFCE40E),))
      ), 
      itemCount: 3
    );
  }

  Widget _generatePersonListElement() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.showPerson),
      child: Row(
        children: [
          // Widgets.listImage(),
          Text(
            "Rodolfo",
            style: TextStyle(
              fontSize: 18.sp,
            ),
          )
        ],
      ),
    );
  }
}
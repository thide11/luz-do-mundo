import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/base_person.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';

class PersonSelector extends StatelessWidget {
  final List<BasePerson>? persons;
  final void Function(BasePerson person) onTap;
  final String title;

  const PersonSelector({
    Key? key,
    this.persons,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0.r),
          bottom: Radius.circular(15.0.r),
        ),
      ),
      child: Container(
        height: 475.h,
        decoration: BoxDecoration(
          color: Color(0xFFE5E5E5),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0.r),
            bottom: Radius.circular(15.0.r),
          ),
        ),
        child: Column(
          children: [
            _dialogHeader(),
            SizedBox(
              height: 415.h,
              child: persons != null
                  ? _dialogBody()
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dialogHeader() {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Color(0xFF070A22),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _dialogBody() {
    return ListView.separated(
      padding:
          EdgeInsets.only(right: 22.5.w, left: 22.5.w, top: 5.h, bottom: 20.h),
      separatorBuilder: (context, index) {
        return Container(height: 1.h, width: 251.w, color: Color(0xFFD0D0D0));
      },
      itemBuilder: (context, index) {
        final person = persons![index];
        return InkWell(
          onTap: () {
            Navigator.of(context).pop();
            onTap(person);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0.h),
            child: Row(
              children: [
                SizedBox(
                  width: 21.w,
                ),
                Widgets.listImage(person.picture ?? AppFile.empty()),
                SizedBox(
                  width: 9.w,
                ),
                Text(person.name),
              ],
            ),
          ),
        );
      },
      itemCount: persons!.length,
    );
  }
}

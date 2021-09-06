import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget generateScreenUtilInit({required Widget child}) {
  return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => child
  );
}
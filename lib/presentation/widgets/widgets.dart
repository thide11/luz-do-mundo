import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/presentation/theme/app_colors.dart';

import 'app_file_to_image_provider.dart';

abstract class Widgets {
  static scaffold(
    BuildContext context, {
    required String title,
    Widget? leading,
    List<Widget>? actions,
    bool mostrarAppBar = true,
    required Widget child,
  }) {
    return Scaffold(
      appBar: mostrarAppBar
          ? AppBar(
              title: Text(title),
              leading: leading,
              actions: actions,
            )
          : null,
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: child,
      ),
    );
  }

  static _baseButton({required Widget child, required void Function() onTap}) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.alternative.withOpacity(0.4),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
          vertical: 8.h,
        ),
        width: 284.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.alternative,
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
        ),
        child: Center(child: child),
      ),
    );
  }

  static button({required String text, required void Function() onTap}) {
    return Widgets._baseButton(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24.sp,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    );
  }

  static buttonWithIcon({
    required String text,
    required IconData icon,
    required void Function() onTap,
    TextStyle? textStyle,
  }) {
    return Widgets._baseButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(
            width: 10.w,
          ),
          Text(
            text,
            style: textStyle,
          )
        ],
      ),
      onTap: onTap,
    );
  }

  static listImage(AppFile appFile) {
    return Container(
      height: 48.r,
      width: 48.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24.0.r)),
        border: Border.all(width: 1.w),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: appFileToImageProvider(appFile)
        ),
      ),
    );
  }


}

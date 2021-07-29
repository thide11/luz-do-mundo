import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/theme/app_colors.dart';

final theme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.alternative,
  buttonTheme: ButtonThemeData( // 4
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    buttonColor: AppColors.alternative,
  ),
  textTheme: TextTheme(
    
  )
);
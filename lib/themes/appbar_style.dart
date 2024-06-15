import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class AppbarStyle{
  static AppBarTheme getAppbarStyle() => const AppBarTheme(
    backgroundColor: AppColor.appBarBackgroundColor,
    foregroundColor: AppColor.appBarForegroundColor,
    surfaceTintColor: AppColor.appBarBackgroundColor,
    elevation: 0,
    actionsIconTheme: IconThemeData(size: 27)
  );
}

import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class AppElevatedButtonStyle {
  static ElevatedButtonThemeData getElevatedButtonStyle() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          elevation: 0,
          backgroundColor: AppColor.appPrimaryColor,
          foregroundColor: AppColor.elevatedButtonForegroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class AppTextFieldStyle{
  static InputDecorationTheme getTextFieldTheme() => InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(
        color: AppColor.textFieldHintColor,
        fontSize: 13,
        fontWeight: FontWeight.normal,
        fontFamily: "Poppins"
      ),
      border: OutlineInputBorder(
          borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(5)
      )
  );
}
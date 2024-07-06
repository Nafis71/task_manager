import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class AppTextFieldStyle {
  static InputDecorationTheme getTextFieldThemeLight() => InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        focusColor: AppColor.appPrimaryColor,
        floatingLabelStyle:
            const TextStyle(color: AppColor.appPrimaryColor, fontSize: 14),
        contentPadding: const EdgeInsets.all(8),
        hintStyle: TextStyle(
            color: AppColor.textFieldHintColor,
            fontSize: 13,
            fontWeight: FontWeight.normal,
            fontFamily: "Poppins"),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.appPrimaryColor, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      );

  static InputDecorationTheme getTextFieldThemeDark() =>
      getTextFieldThemeLight().copyWith(
          fillColor: AppColor.textFieldColorDark,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1)));
}

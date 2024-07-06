import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class AppTextStyle {
  static TextTheme getTextStyleLight() => TextTheme(
        headlineLarge: getDefaultTextStyle().copyWith(
            fontSize: 28,
            color: AppColor.headLineTextLargeColorLight,
            fontFamily: "Poppins Bold"),
        titleLarge: getDefaultTextStyle().copyWith(
          fontSize: 20,
          color: AppColor.headLineTextLargeColorLight,
        ),
        titleMedium: getDefaultTextStyle().copyWith(
          fontSize: 15,
          color: AppColor.headLineTextLargeColorLight,
        ),
        titleSmall: getDefaultTextStyle().copyWith(
          fontSize: 10,
          color: AppColor.headLineTextLargeColorLight,
        ),
        bodySmall: getDefaultTextStyle().copyWith(
          fontSize: 11,
          color: AppColor.bodySmallTextColor,
        ),
        bodyMedium: getDefaultTextStyle(),
        labelMedium: getDefaultTextStyle().copyWith(
          fontSize: 14.5,
          color: AppColor.labelSmallTextColor,
        ),
        labelSmall: getDefaultTextStyle().copyWith(
          fontSize: 9,
          color: AppColor.labelSmallTextColor,
        ),
      );

  static TextTheme getTextStyleDark() => getTextStyleLight().copyWith(
        titleMedium: getDefaultTextStyle().copyWith(
          fontSize: 15,
          color: AppColor.headLineTextLargeColorDark,
        ),
        titleLarge: getDefaultTextStyle().copyWith(
          fontSize: 20,
          color: AppColor.headLineTextLargeColorDark,
        ),
        titleSmall: getDefaultTextStyle().copyWith(
          fontSize: 10,
          color: AppColor.headLineTextLargeColorDark,
        ),
        headlineLarge: getDefaultTextStyle().copyWith(
            fontSize: 28,
            color: AppColor.headLineTextLargeColorDark,
            fontFamily: "Poppins Bold"),
    bodyMedium: getDefaultTextStyle().copyWith(
      color: AppColor.bodyMediumTextColorDark
    )
      );

  static TextStyle getDefaultTextStyle() => const TextStyle(
      fontSize: 13,
      color: AppColor.bodyMediumTextColorLight,
      fontFamily: "Poppins",
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5);
}

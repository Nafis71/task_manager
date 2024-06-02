import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class AppTextStyle{
  static TextTheme getTextStyle() => const TextTheme(
    headlineLarge: TextStyle(
        fontSize: 28,
        color: AppColor.headLineTextLargeColor,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins",
        letterSpacing: 0.5
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: AppColor.bodySmallTextColor,
      fontFamily: "Poppins",
      letterSpacing: 0.5
    ),
    bodyMedium: TextStyle(
        fontSize: 13,
        color: AppColor.bodyMediumTextColor,
        fontFamily: "Poppins",
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5
    )
  );
}
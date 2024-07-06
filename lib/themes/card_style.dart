import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class CardStyle{
  static CardTheme getCardStyleLight() => CardTheme(
    elevation: 0,
    color: AppColor.cardBackgroundColorLight,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  );

  static CardTheme getCardStyleDark() => getCardStyleLight().copyWith(
    color: AppColor.cardBackgroundColorDark
  );
}
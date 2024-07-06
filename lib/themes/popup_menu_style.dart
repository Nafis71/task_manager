import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class PopupMenuStyle {
  static PopupMenuThemeData getPopupMenuLight() => PopupMenuThemeData(
        color: AppColor.popupMenuColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
      );

  static PopupMenuThemeData getPopupMenuDark() => getPopupMenuLight().copyWith(
        color: AppColor.popupMenuColorDark,
      );
}

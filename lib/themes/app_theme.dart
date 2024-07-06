import 'package:flutter/material.dart';
import 'package:task_manager/themes/card_style.dart';
import 'package:task_manager/themes/expansion_tile_style.dart';
import 'package:task_manager/themes/navigation_bar_style.dart';
import 'package:task_manager/themes/popup_menu_style.dart';

import '../utils/app_color.dart';
import 'app_elevated_button_style.dart';
import 'app_text_style.dart';
import 'app_textfield_style.dart';
import 'appbar_style.dart';

class AppTheme {
  static ThemeData getLightTheme() => ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundColorLight,
        textTheme: AppTextStyle.getTextStyleLight(),
        inputDecorationTheme: AppTextFieldStyle.getTextFieldThemeLight(),
        elevatedButtonTheme: AppElevatedButtonStyle.getElevatedButtonStyle(),
        appBarTheme: AppbarStyle.getLightAppbarStyle(),
        cardTheme: CardStyle.getCardStyleLight(),
        popupMenuTheme: PopupMenuStyle.getPopupMenuLight(),
        expansionTileTheme: ExpansionTileStyle.getExpansionStyleLight(),
      );

  static ThemeData getDarkTheme() => getLightTheme().copyWith(
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundColorDark,
        appBarTheme: AppbarStyle.getDarkAppbarStyle(),
        cardTheme: CardStyle.getCardStyleDark(),
        textTheme: AppTextStyle.getTextStyleDark(),
        inputDecorationTheme: AppTextFieldStyle.getTextFieldThemeDark(),
        popupMenuTheme: PopupMenuStyle.getPopupMenuDark(),
        expansionTileTheme: ExpansionTileStyle.getExpansionStyleDark(),
      );
}

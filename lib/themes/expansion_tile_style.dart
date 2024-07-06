import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class ExpansionTileStyle {
  static ExpansionTileThemeData getExpansionStyleLight() =>
      ExpansionTileThemeData(
        tilePadding: const EdgeInsets.symmetric(horizontal: 0),
        expansionAnimationStyle: AnimationStyle(
          curve: Curves.linearToEaseOut,
          duration: const Duration(milliseconds: 700),
        ),
        collapsedIconColor: AppColor.expansionTileCollapsedIconColor,
        childrenPadding: const EdgeInsets.only(bottom: 5),
        shape: const Border(),
      );

  static ExpansionTileThemeData getExpansionStyleDark() =>
      getExpansionStyleLight();
}

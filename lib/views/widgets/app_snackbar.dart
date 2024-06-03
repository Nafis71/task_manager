import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

SnackBar getSnackBar({required String title, required String content, required ContentType contentType, required Color color}) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      titleFontSize: 16,
      messageFontSize: 13,
      message: content,
      color: color,
      contentType: contentType,

    ),
  );
}

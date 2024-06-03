import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/wrappers/widget_custom_animator.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

SnackBar getSnackBar({required String title, required String content, required ContentType contentType, required Color color}) {
  return SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    dismissDirection: DismissDirection.down,
    content: WidgetCustomAnimator(
      incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(duration: const Duration(seconds: 1),scale: 0.4,opacity: 0.1),
      childWidget: AwesomeSnackbarContent(
        title: title,
        titleFontSize: 16,
        messageFontSize: 13,
        message: content,
        color: color,
        contentType: contentType,
      ),
    ),
  );
}

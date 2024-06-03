import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

import '../../utils/app_strings.dart';

class AppTextField extends StatelessWidget {
  final FocusNode focusNode;
  final bool isObscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Function(String)? onFieldSubmitted;
  final String hintText;
  final TextInputType inputType;

  const AppTextField(
      {super.key,
      required this.focusNode,
      this.isObscureText = false,
      required this.controller,
      this.suffixIcon,
      this.onFieldSubmitted,
      required this.hintText,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      focusNode: focusNode,
      controller: controller,
      obscureText: isObscureText,
      obscuringCharacter: AppStrings.obscuringChar,
      cursorColor: AppColor.appPrimaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}

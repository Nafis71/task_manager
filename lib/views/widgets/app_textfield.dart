import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

import '../../utils/app_strings.dart';

class AppTextField extends StatelessWidget {
  final FocusNode focusNode;
  final bool isObscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Function(String)? onFieldSubmitted;
  final String hintText, errorText, regEx;
  final TextInputType inputType;
  final int? maxLength;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final bool disableValidation, setCustomValidation;
  final Function(String value)? onChanged, customValidation;
  final OutlineInputBorder? outlineInputBorder;

  const AppTextField({
    super.key,
    required this.focusNode,
    this.isObscureText = false,
    required this.controller,
    this.suffixIcon,
    this.onFieldSubmitted,
    this.hintText = "",
    required this.inputType,
    this.errorText = "",
    this.regEx = "",
    this.maxLength,
    this.onChanged,
    this.setCustomValidation = false,
    this.customValidation,
    this.disableValidation = false,
    this.textStyle,
    this.textAlign,
    this.outlineInputBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: inputType,
      style: textStyle,
      focusNode: focusNode,
      autofocus: false,
      controller: controller,
      maxLength: maxLength,
      obscureText: isObscureText,
      obscuringCharacter: AppStrings.obscuringChar,
      cursorColor: AppColor.appPrimaryColor,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          counterText: "",
          focusedBorder: outlineInputBorder),
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTapOutside: (value) {
        FocusScope.of(context).unfocus();
      },
      validator: (value) {
        if (disableValidation) {
          return null;
        }
        if (setCustomValidation) {
          return customValidation!(value.toString());
        }
        if (value!.isEmpty ||
            (regEx.isNotEmpty && !RegExp(regEx).hasMatch(value))) {
          return errorText;
        }
        return null;
      },
      autovalidateMode: (!disableValidation)
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/app_textfield.dart';

class PinVerificationForm extends StatelessWidget {
  final TextEditingController firstPinTEController;
  final TextEditingController secondPinTEController;
  final TextEditingController thirdPinTEController;
  final TextEditingController fourthPinTEController;
  final TextEditingController fifthPinTEController;
  final TextEditingController sixthPinTEController;
  final FocusNode firstPinFocusNode;
  final FocusNode secondPinFocusNode;
  final FocusNode thirdPinFocusNode;
  final FocusNode fourthPinFocusNode;
  final FocusNode fifthPinFocusNode;
  final FocusNode sixthPinFocusNode;
  final double textFieldHeight = 50;
  final double textFieldWidth;

  const PinVerificationForm(
      {super.key,
      required this.firstPinTEController,
      required this.secondPinTEController,
      required this.thirdPinTEController,
      required this.fourthPinTEController,
      required this.fifthPinTEController,
      required this.sixthPinTEController,
      required this.firstPinFocusNode,
      required this.secondPinFocusNode,
      required this.thirdPinFocusNode,
      required this.fourthPinFocusNode,
      required this.fifthPinFocusNode,
      required this.sixthPinFocusNode,
      required this.textFieldWidth});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: textFieldWidth,
            height: textFieldHeight,
            child: AppTextField(
              focusNode: firstPinFocusNode,
              controller: firstPinTEController,
              inputType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              disableValidation: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  FocusScope.of(context).requestFocus(secondPinFocusNode);
                }
              },
            ),
          ),
          const Gap(8),
          SizedBox(
            width: textFieldWidth,
            height: textFieldHeight,
            child: AppTextField(
              focusNode: secondPinFocusNode,
              controller: secondPinTEController,
              inputType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              disableValidation: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  FocusScope.of(context).requestFocus(thirdPinFocusNode);
                }
              },
            ),
          ),
          const Gap(8),
          SizedBox(
            width: textFieldWidth,
            height: textFieldHeight,
            child: AppTextField(
              focusNode: thirdPinFocusNode,
              controller: thirdPinTEController,
              inputType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              disableValidation: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  FocusScope.of(context).requestFocus(fourthPinFocusNode);
                }
              },
            ),
          ),
          const Gap(8),
          SizedBox(
            width: textFieldWidth,
            height: textFieldHeight,
            child: AppTextField(
              focusNode: fourthPinFocusNode,
              controller: fourthPinTEController,
              inputType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              disableValidation: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  FocusScope.of(context).requestFocus(fifthPinFocusNode);
                }
              },
            ),
          ),
          const Gap(8),
          SizedBox(
            width: textFieldWidth,
            height: textFieldHeight,
            child: AppTextField(
              focusNode: fifthPinFocusNode,
              controller: fifthPinTEController,
              inputType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              disableValidation: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  FocusScope.of(context).requestFocus(sixthPinFocusNode);
                }
              },
            ),
          ),
          const Gap(8),
          SizedBox(
            height: textFieldHeight,
            width: textFieldWidth,
            child: AppTextField(
              focusNode: sixthPinFocusNode,
              controller: sixthPinTEController,
              inputType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              disableValidation: true,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

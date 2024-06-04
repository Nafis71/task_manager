import 'package:flutter/material.dart';
import '../../widgets/app_textfield.dart';

class PinVerificationForm extends StatelessWidget {
  final List<TextEditingController> pinTEControllers;
  final List<FocusNode> focusNodes;
  final double textFieldHeight = 50;
  final double textFieldWidth;

  const PinVerificationForm(
      {super.key,
      required this.textFieldWidth,
      required this.pinTEControllers,
      required this.focusNodes});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(focusNodes.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: SizedBox(
              width: textFieldWidth,
              height: textFieldHeight,
              child: AppTextField(
                focusNode: focusNodes[index],
                controller: pinTEControllers[index],
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
                    if (index == focusNodes.length - 1) {
                      FocusScope.of(context).unfocus();
                    } else {
                      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                    }
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}

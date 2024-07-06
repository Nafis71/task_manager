import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';

class ResendPinLayout extends StatelessWidget {
  final int resendTimeLeft;
  final String email;
  final Function restartTimer;

  const ResendPinLayout(
      {super.key,
      required this.resendTimeLeft,
      required this.email,
      required this.restartTimer});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text((resendTimeLeft == 60)
            ? "1:00"
            : "0:${resendTimeLeft.toString().padLeft(2, "0")}"),
        InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            if (resendTimeLeft != 0) {
              return;
            }
            await context
                .read<AuthViewModel>()
                .sendOTP(email, isResending: true);
            restartTimer();
          },
          child: Text(
            "Resend",
            style: TextStyle(
              color: (resendTimeLeft == 0)
                  ? AppColor.appPrimaryColor
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

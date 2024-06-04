import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';
import 'package:task_manager/views/forgetPasswordScreen/pinVerification/pin_verification_form.dart';
import 'package:task_manager/views/widgets/forget_password_layout.dart';
import '../../../utils/app_color.dart';
import '../../../utils/app_routes.dart';
import '../../widgets/circular_progressbar.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  late final List<TextEditingController> pinTEControllers;

  late final List<FocusNode> focusNodes;

  final double textFieldHeight = 50;

  @override
  void initState() {
    pinTEControllers = List.generate(6, (index) => TextEditingController());
    focusNodes = List.generate(6, (index) => FocusNode());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double textFieldWidth = screenWidth * 0.11;
    return Scaffold(
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return ForgetPasswordLayout(
            orientation: orientation,
            horizontalMargin: screenWidth * 0.1,
            verticalMargin: (orientation == Orientation.portrait)
                ? screenHeight * 0.25
                : screenHeight * 0.15,
            headerText: AppStrings.pinVerificationHeaderText,
            bodyText: AppStrings.pinVerificationBodyText,
            screenWidth: screenWidth,
            buttonWidget: Consumer<AuthViewModel>(
              builder: (_, viewModel, __) {
                return (viewModel.isLoading)
                    ? const CircularProgressbar(
                        color: AppColor.circularProgressbarColor)
                    : const Text(AppStrings.pinVerificationButtonText);
              },
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, AppRoutes.setPasswordScreen);
            },
            child: PinVerificationForm(
              textFieldWidth: textFieldWidth,
              pinTEControllers: pinTEControllers,
              focusNodes: focusNodes,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (TextEditingController controller in pinTEControllers) {
      controller.dispose();
    }
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}

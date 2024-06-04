import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_navigation.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';
import 'package:task_manager/views/forgetPasswordScreen/pinVerification/pin_verification_form.dart';
import 'package:task_manager/views/widgets/app_textfield.dart';
import 'package:task_manager/views/widgets/background_widget.dart';
import 'package:task_manager/views/widgets/sign_in_bottom_text.dart';
import '../../../utils/app_color.dart';
import '../../widgets/app_elevated_button.dart';
import '../../widgets/circular_progressbar.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  late final TextEditingController firstPinTEController;
  late final TextEditingController secondPinTEController;
  late final TextEditingController thirdPinTEController;
  late final TextEditingController fourthPinTEController;
  late final TextEditingController fifthPinTEController;
  late final TextEditingController sixthPinTEController;
  late final FocusNode firstPinFocusNode;
  late final FocusNode secondPinFocusNode;
  late final FocusNode thirdPinFocusNode;
  late final FocusNode fourthPinFocusNode;
  late final FocusNode fifthPinFocusNode;
  late final FocusNode sixthPinFocusNode;
  final double textFieldHeight = 50;

  @override
  void initState() {
    firstPinTEController = TextEditingController();
    secondPinTEController = TextEditingController();
    thirdPinTEController = TextEditingController();
    fourthPinTEController = TextEditingController();
    fifthPinTEController = TextEditingController();
    sixthPinTEController = TextEditingController();
    firstPinFocusNode = FocusNode();
    secondPinFocusNode = FocusNode();
    thirdPinFocusNode = FocusNode();
    fourthPinFocusNode = FocusNode();
    fifthPinFocusNode = FocusNode();
    sixthPinFocusNode = FocusNode();
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
          return BackgroundWidget(
            childWidget: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: (orientation == Orientation.portrait)
                        ? screenHeight * 0.25
                        : screenHeight * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.pinVerificationHeaderText,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Gap(5),
                    Text(
                      AppStrings.pinVerificationBodyText,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Gap(10),
                    PinVerificationForm(
                      firstPinTEController: firstPinTEController,
                      secondPinTEController: secondPinTEController,
                      thirdPinTEController: thirdPinTEController,
                      fourthPinTEController: fourthPinTEController,
                      fifthPinTEController: fifthPinTEController,
                      sixthPinTEController: sixthPinTEController,
                      firstPinFocusNode: firstPinFocusNode,
                      secondPinFocusNode: secondPinFocusNode,
                      thirdPinFocusNode: thirdPinFocusNode,
                      fourthPinFocusNode: fourthPinFocusNode,
                      fifthPinFocusNode: fifthPinFocusNode,
                      sixthPinFocusNode: sixthPinFocusNode,
                      textFieldWidth: textFieldWidth,
                    ),
                    const Gap(20),
                    Consumer<AuthViewModel>(builder: (_, viewModel, __) {
                      return AppElevatedButton(
                        screenWidth: screenWidth,
                        childWidget: (viewModel.isLoading)
                            ? const CircularProgressbar(
                                color: AppColor.circularProgressbarColor)
                            : const Text(AppStrings.pinVerificationButtonText),
                        onPressed: () {
                          //TODO will change the logic later
                          // Navigator.pushNamed(context, AppRoutes.pinVerificationScreen);
                        },
                      );
                    }),
                    const Gap(20),
                    SignInBottomText(route: () {
                      AppNavigation.gotoSignIn(context);
                    })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    firstPinTEController.dispose();
    secondPinTEController.dispose();
    thirdPinTEController.dispose();
    fourthPinTEController.dispose();
    fifthPinTEController.dispose();
    sixthPinTEController.dispose();
    firstPinFocusNode.dispose();
    secondPinFocusNode.dispose();
    thirdPinFocusNode.dispose();
    fourthPinFocusNode.dispose();
    fifthPinFocusNode.dispose();
    sixthPinFocusNode.dispose();
    super.dispose();
  }
}

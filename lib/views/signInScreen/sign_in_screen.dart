import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_routes.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/views/signInScreen/sign_in_screen_form.dart';
import '../widgets/background_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late final TextEditingController _emailTEController;
  late final TextEditingController _passwordTEController;
  late final GlobalKey<FormState> _formKey;
  late final FocusNode _emailFocusNode = FocusNode();
  late final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _emailTEController = TextEditingController();
    _passwordTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OrientationBuilder(builder: (BuildContext context, Orientation orientation) {
        return BackgroundWidget(
          childWidget: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1, vertical:(orientation ==Orientation.portrait) ? screenHeight * 0.25 : screenHeight * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.signInHeaderText,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Gap(20),
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: SignInScreenForm(
                      emailTEController: _emailTEController,
                      passwordTEController: _passwordTEController,
                      formKey: _formKey,
                      emailFocusNode: _emailFocusNode,
                      passwordFocusNode: _passwordFocusNode,
                      screenWidth: screenWidth,
                    ),
                  ),
                  const Gap(50),
                  Center(
                    child: Text(
                      AppStrings.forgetPasswordText,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  const Gap(10),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: AppStrings.signInBottomTextOne,
                        style: Theme.of(context).textTheme.bodyMedium,
                        children:  [
                          TextSpan(
                            text: AppStrings.signInBottomTextTwo,
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.pushNamed(context, AppRoutes.signUpScreen);
                            },
                            style: const TextStyle(
                              color: AppColor.appPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },),
    );
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}

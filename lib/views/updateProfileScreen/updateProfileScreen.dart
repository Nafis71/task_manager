import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/views/widgets/app_bar.dart';
import 'package:task_manager/views/widgets/app_textfield.dart';
import 'package:task_manager/views/widgets/background_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late final TextEditingController _emailTEController,
      _firstNameTEController,
      _lastNameTEController,
      _mobileNumberTEController,
      _passwordTEController;
  late final GlobalKey<FormState> _formKey;
  late final FocusNode _emailFocusNode,
      _passwordFocusNode,
      _firstNameFocusNode,
      _lastNameFocusNode,
      _mobileNumberFocusNode;

  @override
  void initState() {
    _emailTEController = TextEditingController();
    _firstNameTEController = TextEditingController();
    _lastNameTEController = TextEditingController();
    _mobileNumberTEController = TextEditingController();
    _passwordTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _mobileNumberFocusNode = FocusNode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getApplicationAppBar(context),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return BackgroundWidget(
            childWidget: SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.updateProfileScreenTitle,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const Gap(15),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: screenWidth * 0.25,
                        decoration: const BoxDecoration(
                          color: AppColor.photoPickerColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppStrings.photoPickerText,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ),
                    ),
                    const Gap(20),
                    AppTextField(
                        focusNode: _emailFocusNode,
                        controller: _emailTEController,
                        inputType: TextInputType.emailAddress,
                      hintText: AppStrings.emailTextFieldHint,
                      errorText: AppStrings.emailErrorText,
                      onFieldSubmitted: (value){
                          FocusScope.of(context).requestFocus(_firstNameFocusNode);
                      },
                    ),
                    const Gap(20),
                    AppTextField(
                      focusNode: _firstNameFocusNode,
                      controller: _firstNameTEController,
                      inputType: TextInputType.text,
                      hintText: AppStrings.firstNameTextFieldHint,
                      errorText: AppStrings.firstNameErrorText,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(_lastNameFocusNode);
                      },
                    ),
                    const Gap(20),
                    AppTextField(
                      focusNode: _lastNameFocusNode,
                      controller: _lastNameTEController,
                      inputType: TextInputType.text,
                      hintText: AppStrings.lastNameTextFieldHint,
                      errorText: AppStrings.lastNameErrorText,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(_mobileNumberFocusNode);
                      },
                    ),
                    const Gap(20),
                    AppTextField(
                      focusNode: _mobileNumberFocusNode,
                      controller: _mobileNumberTEController,
                      inputType: TextInputType.number,
                      hintText: AppStrings.mobileNumberTextFieldHint,
                      errorText: AppStrings.mobileNumberErrorText,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const Gap(20),
                    AppTextField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordTEController,
                      inputType: TextInputType.text,
                      hintText: AppStrings.passwordTextFieldHint,
                      errorText: AppStrings.passwordErrorText,
                      onFieldSubmitted: (value){
                        FocusScope.of(context).unfocus();
                      },
                    )
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
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileNumberTEController.dispose();
    _passwordTEController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _mobileNumberFocusNode.dispose();
    super.dispose();
  }
}

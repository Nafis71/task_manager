import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/views/widgets/app_bar.dart';
import 'package:task_manager/views/widgets/app_elevated_button.dart';
import 'package:task_manager/views/widgets/app_textfield.dart';
import 'package:task_manager/views/widgets/background_widget.dart';

import '../../utils/app_color.dart';
import '../widgets/circular_progressbar.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final FocusNode subjectFocusNode;
  late final FocusNode descriptionFocusNode;
  late final TextEditingController subjectTEController;
  late final TextEditingController descriptionTEController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    subjectTEController = TextEditingController();
    descriptionTEController = TextEditingController();
    subjectFocusNode = FocusNode();
    descriptionFocusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getApplicationAppBar(context),
      body: OrientationBuilder(builder: (context, orientation) {
        return BackgroundWidget(
            childWidget: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.addTaskScreenTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const Gap(15),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        focusNode: subjectFocusNode,
                        controller: subjectTEController,
                        inputType: TextInputType.text,
                        hintText: AppStrings.subjectTextFieldHint,
                      ),
                      const Gap(15),
                      AppTextField(
                        focusNode: descriptionFocusNode,
                        controller: descriptionTEController,
                        inputType: TextInputType.text,
                        hintText: AppStrings.descriptionTextFieldHint,
                        maxLines: 16,
                        minLines: 10,
                      ),
                      const Gap(25),
                      AppElevatedButton(
                        screenWidth: screenWidth,
                        onPressed: (viewModel) {},
                        loadingChild: const CircularProgressbar(
                            color: AppColor.circularProgressbarColor),
                        placeHolderChild: const Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
      }),
    );
  }
  @override
  void dispose() {
    subjectTEController.dispose();
    subjectFocusNode.dispose();
    descriptionTEController.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }
}

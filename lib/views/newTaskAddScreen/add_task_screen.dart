import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/task_view_model.dart';
import 'package:task_manager/viewModels/user_view_model.dart';
import 'package:task_manager/views/widgets/app_bar.dart';
import 'package:task_manager/views/widgets/app_snackbar.dart';
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
      appBar: getApplicationAppBar(context: context, disableNavigation: false),
      body: OrientationBuilder(builder: (context, orientation) {
        return BackgroundWidget(
          childWidget: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(descriptionFocusNode);
                          },
                        ),
                        const Gap(15),
                        AppTextField(
                          focusNode: descriptionFocusNode,
                          controller: descriptionTEController,
                          inputType: TextInputType.multiline,
                          hintText: AppStrings.descriptionTextFieldHint,
                          maxLines: 16,
                          minLines: 10,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        const Gap(25),
                        SizedBox(
                          width: screenWidth * 0.9,
                          child: Consumer<TaskViewModel>(
                            builder: (_, viewModel, __) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() && !context.read<TaskViewModel>().isLoading) {
                                    addTask();
                                  }
                                },
                                child: viewModel.isLoading
                                    ? const CircularProgressbar(
                                        color:
                                            AppColor.circularProgressbarColor)
                                    : const Icon(
                                        Icons.arrow_circle_right_outlined,
                                        size: 30,
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void addTask() async {
    bool status = await context.read<TaskViewModel>().createTask(
        context.read<UserViewModel>().token,
        subjectTEController.text,
        descriptionTEController.text);
    if (status && mounted) {
      AppSnackBar().showSnackBar(title: AppStrings.newTaskAddSuccessTitle,
          content: AppStrings.newTaskAddSuccessMessage,
          contentType: ContentType.success,
          color: AppColor.snackBarSuccessColor,
          context: context);
      Navigator.pop(context, true);
      return;
    }
    if (mounted) {
      AppSnackBar().showSnackBar(title: AppStrings.newTaskAddFailureTitle,
          content: AppStrings.newTaskAddFailureMessage,
          contentType: ContentType.failure,
          color: AppColor.snackBarFailureColor,
          context: context);
    }
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

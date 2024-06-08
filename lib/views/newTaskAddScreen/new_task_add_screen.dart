import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/views/widgets/task_status_card.dart';

import '../../viewModels/task_view_model.dart';
import '../../viewModels/user_view_model.dart';

class NewTaskAddScreen extends StatefulWidget {
  const NewTaskAddScreen({super.key});

  @override
  State<NewTaskAddScreen> createState() => _NewTaskAddScreenState();
}

class _NewTaskAddScreenState extends State<NewTaskAddScreen> {
  @override
  void initState() {
    // TODO: implement initState
    calll();
    super.initState();
  }

  void calll() async {
    bool status = await context
        .read<TaskViewModel>()
        .fetchTaskStatusData(context.read<UserViewModel>().token);
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<TaskViewModel>(
                  builder: (_, viewModel, __) {
                    return Row(
                      children: [
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: viewModel.taskStatusCount["Canceled"]
                                    ?.padLeft(2, "0") ??
                                "0",
                            subtitleText: "Canceled"),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: viewModel.taskStatusCount["Completed"]
                                    ?.padLeft(2, "0") ??
                                "0",
                            subtitleText: "Completed"),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: viewModel.taskStatusCount["Progress"]
                                    ?.padLeft(2, "0") ??
                                "0",
                            subtitleText: "Progress"),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: viewModel.taskStatusCount["New"]
                                    ?.padLeft(2, "0") ??
                                "0",
                            subtitleText: "New Task"),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/views/widgets/task_list_card.dart';
import 'package:task_manager/views/widgets/task_status_card.dart';

import '../../viewModels/task_view_model.dart';
import '../../viewModels/user_view_model.dart';

class NewTaskAddScreen extends StatefulWidget {
  const NewTaskAddScreen({super.key});

  @override
  State<NewTaskAddScreen> createState() => _NewTaskAddScreenState();
}

class _NewTaskAddScreenState extends State<NewTaskAddScreen> {
  AppLifecycleState appLifecycleState = AppLifecycleState.detached;

  @override
  void initState() {
    super.initState();
    fetchStatusData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          color: AppColor.appPrimaryColor,
          onRefresh: ()async{
            await fetchStatusData();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<TaskViewModel>(
                  builder: (_, viewModel, __) {
                    if(viewModel.taskStatusCount.isEmpty){
                      return const SizedBox.shrink();
                    }
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
              const Gap(5),
              Consumer<TaskViewModel>(builder: (_, viewModel, __) {
                if (viewModel.taskDataByStatus["New"] == null) {
                  return const Expanded(child: Center(child: CircularProgressIndicator(color: AppColor.appPrimaryColor,)));
                }
                return TaskListCard(
                    screenWidth: screenWidth,
                    taskData: viewModel.taskDataByStatus["New"]!);
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchStatusData() async {
    await context
        .read<TaskViewModel>()
        .fetchTaskStatusData(context.read<UserViewModel>().token);
    await fetchListData();
  }

  Future<void> fetchListData() async {
    await context
        .read<TaskViewModel>()
        .fetchTaskList(context.read<UserViewModel>().token, "New");
  }
}

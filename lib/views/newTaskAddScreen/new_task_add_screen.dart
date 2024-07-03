import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_routes.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/views/widgets/loading_layout.dart';
import 'package:task_manager/views/widgets/no_data_layout.dart';
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
    if(context.read<TaskViewModel>().taskDataByStatus["New"] == null){
      fetchTasksData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenHeight,
        margin: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          color: AppColor.appPrimaryColor,
          onRefresh: () async {
            await fetchTasksData();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Consumer<TaskViewModel>(
                  builder: (_, viewModel, __) {
                    if (viewModel.taskStatusCount.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Row(
                      children: [
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText:
                                (viewModel.taskStatusCount[AppStrings.taskStatusCanceled] != "0")
                                    ? viewModel.taskStatusCount[AppStrings.taskStatusCanceled]
                                            ?.padLeft(2, "0") ??
                                        "0"
                                    : "0",
                            subtitleText: "Canceled"),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText:
                                (viewModel.taskStatusCount[AppStrings.taskStatusCompleted] != "0")
                                    ? viewModel.taskStatusCount[AppStrings.taskStatusCompleted]
                                            ?.padLeft(2, "0") ??
                                        "0"
                                    : "0",
                            subtitleText: AppStrings.taskStatusCompleted),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText:
                                (viewModel.taskStatusCount[AppStrings.taskStatusProgress] != "0")
                                    ? viewModel.taskStatusCount[AppStrings.taskStatusProgress]
                                            ?.padLeft(2, "0") ??
                                        "0"
                                    : "0",
                            subtitleText: AppStrings.taskStatusProgress),
                        TaskStatusCard(
                            screenWidth: screenWidth,
                            titleText: (viewModel.taskStatusCount[AppStrings.taskStatusNew] != "0")
                                ? viewModel.taskStatusCount[AppStrings.taskStatusNew]
                                        ?.padLeft(2, "0") ??
                                    "0"
                                : "0",
                            subtitleText: AppStrings.taskStatusNew),
                      ],
                    );
                  },
                ),
              ),
              const Gap(5),
              Consumer<TaskViewModel>(builder: (_, viewModel, __) {
                if (viewModel.taskDataByStatus[AppStrings.taskStatusNew] == null) {
                  return const LoadingLayout();
                }
                if (viewModel.taskDataByStatus[AppStrings.taskStatusNew]!.isEmpty) {
                  return const NoDataLayout(
                    noDataMessage: AppStrings.noNewTaskData,
                  );
                }
                return TaskListCard(
                  screenWidth: screenWidth,
                  taskData: viewModel.taskDataByStatus[AppStrings.taskStatusNew]!,
                  chipColor: AppColor.newTaskChipColor,
                  currentScreen: AppStrings.taskStatusNew,
                );
              })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTaskScreen);
        },
        backgroundColor: AppColor.appPrimaryColor,
        child: const Icon(Icons.add, size: 27),
        //params
      ),
    );
  }

  Future<void> fetchTasksData() async {
    if(mounted){
      await context
          .read<TaskViewModel>()
          .fetchTaskStatusData(context.read<UserViewModel>().token);
    }
    if(mounted){
      await context
          .read<TaskViewModel>()
          .fetchTaskList(context.read<UserViewModel>().token);
    }

  }
}

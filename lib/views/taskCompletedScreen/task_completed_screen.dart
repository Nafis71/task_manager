import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../viewModels/task_view_model.dart';
import '../../viewModels/user_view_model.dart';
import '../widgets/task_list_card.dart';
import '../widgets/task_status_card.dart';

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({super.key});

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
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
        margin: const EdgeInsets.all(8),
        child: RefreshIndicator(
          color: AppColor.appPrimaryColor,
          onRefresh: () async {
            await fetchStatusData();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(5),
              Consumer<TaskViewModel>(builder: (_, viewModel, __) {
                if (viewModel.taskDataByStatus["Completed"] == null) {
                  return const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                    color: AppColor.appPrimaryColor,
                  )));
                }
                return TaskListCard(
                  screenWidth: screenWidth,
                  taskData: viewModel.taskDataByStatus["Completed"]!,
                  chipColor: AppColor.completedChipColor,
                );
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
        .fetchTaskList(context.read<UserViewModel>().token, "Completed");
  }
}

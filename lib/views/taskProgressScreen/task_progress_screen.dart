import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../viewModels/task_view_model.dart';
import '../../viewModels/user_view_model.dart';
import '../widgets/task_list_card.dart';

class TaskProgressScreen extends StatefulWidget {
  const TaskProgressScreen({super.key});

  @override
  State<TaskProgressScreen> createState() => _TaskProgressScreenState();
}

class _TaskProgressScreenState extends State<TaskProgressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchListData();
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
            await fetchListData();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(5),
              Consumer<TaskViewModel>(builder: (_, viewModel, __) {
                if (viewModel.taskDataByStatus["Progress"] == null) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.appPrimaryColor,
                      ),
                    ),
                  );
                }
                return TaskListCard(
                  screenWidth: screenWidth,
                  taskData: viewModel.taskDataByStatus["Progress"]!,
                  chipColor: AppColor.progressChipColor,
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchListData() async {
    await context
        .read<TaskViewModel>()
        .fetchTaskList(context.read<UserViewModel>().token, "Progress");
  }
}

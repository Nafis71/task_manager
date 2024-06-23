import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../utils/app_color.dart';
import '../../utils/app_strings.dart';
import '../../viewModels/task_view_model.dart';
import '../../viewModels/user_view_model.dart';
import '../widgets/loading_layout.dart';
import '../widgets/no_data_layout.dart';
import '../widgets/task_list_card.dart';

class TaskCancelledScreen extends StatefulWidget {
  const TaskCancelledScreen({super.key});

  @override
  State<TaskCancelledScreen> createState() => _TaskCancelledScreenState();
}

class _TaskCancelledScreenState extends State<TaskCancelledScreen> {
  @override
  void initState() {
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
                if (viewModel.taskDataByStatus["Canceled"] == null) {
                  return const LoadingLayout();
                }
                if (viewModel.taskDataByStatus["Canceled"]!.isEmpty) {
                  return const NoDataLayout(
                    noDataMessage: AppStrings.noNewCanceledData,
                  );
                }
                return TaskListCard(
                  screenWidth: screenWidth,
                  taskData: viewModel.taskDataByStatus["Canceled"]!,
                  chipColor: AppColor.canceledChipColor,
                  currentScreen: "Canceled",
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
        .fetchTaskList(context.read<UserViewModel>().token, "Canceled");
  }
}

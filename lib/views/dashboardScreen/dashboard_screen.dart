import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:task_manager/utils/app_assets.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/dashboard_view_model.dart';
import 'package:task_manager/viewModels/task_view_model.dart';
import 'package:task_manager/viewModels/user_view_model.dart';
import 'package:task_manager/views/taskCancelledScreen/task_cancelled_screen.dart';
import 'package:task_manager/views/taskCompletedScreen/task_completed_screen.dart';
import 'package:task_manager/views/taskProgressScreen/task_progress_screen.dart';

import '../newTaskAddScreen/new_task_add_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> bottomBarIcons = const [
    // Icons.add,
    // Icons.watch_later_outlined,
    // Icons.done_all, Icons.cancel_outlined

    Icon(Icons.add, size: 25),
    Icon(Icons.watch_later_outlined, size: 25),
    Icon(Icons.done_all, size: 25),
    Icon(Icons.cancel_outlined, size: 25),
  ];
  List<String> bottomBarLabels = [
    AppStrings.bottomBarAdd,
    AppStrings.bottomBarProgress,
    AppStrings.bottomBarCompleted,
    AppStrings.bottomBarCanceled,
  ];
  late final List<BottomNavigationBarItem> bottomNavigationBarItem;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> screens = const [
    NewTaskAddScreen(),
    TaskProgressScreen(),
    TaskCompletedScreen(),
    TaskCancelledScreen(),
  ];

  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<UserViewModel>(
          builder: (_, viewModel, __) {
            return Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: (viewModel.userData.photo!.isEmpty)
                      ? const AssetImage(AppAssets.userDefaultImage)
                      : MemoryImage(
                          base64Decode(
                            viewModel.userData.photo.toString(),
                          ),
                        ),
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${viewModel.userData.firstName} ${viewModel.userData.lastName}",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      viewModel.userData.email.toString(),
                      style: Theme.of(context).textTheme.labelSmall,
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
      body: Consumer<DashboardViewModel>(
        builder: (context, viewModel, child) {
          return IndexedStack(
            index: viewModel.index,
            children: screens,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, backgroundColor: AppColor.appPrimaryColor,
        child: const Icon(Icons.add, size: 27),
        //params
      ),

      bottomNavigationBar: Consumer<DashboardViewModel>(
        builder: (context, viewModel, child) {
          return SalomonBottomBar(
            currentIndex: viewModel.index,
            onTap: (index) => viewModel.setIndex = index,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.add),
                title: const Text("New Task"),
                selectedColor: AppColor.appPrimaryColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.watch_later_outlined),
                title: const Text("Progress"),
                selectedColor: AppColor.appPrimaryColor,
              ),

              SalomonBottomBarItem(
                icon: const Icon(Icons.done_outline_rounded),
                title: const Text("Completed"),
                selectedColor: AppColor.appPrimaryColor,
              ),

              SalomonBottomBarItem(
                icon: const Icon(Icons.cancel_outlined),
                title: const Text("Canceled"),
                selectedColor: AppColor.appPrimaryColor,
              ),
            ],
          );
        },
      ),
    );
  }
}

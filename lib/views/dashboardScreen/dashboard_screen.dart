import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/services/connectivity_checker.dart';
import 'package:task_manager/themes/theme_changer.dart';
import 'package:task_manager/utils/app_assets.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/dashboard_view_model.dart';
import 'package:task_manager/viewModels/task_view_model.dart';
import 'package:task_manager/views/taskCancelledScreen/task_cancelled_screen.dart';
import 'package:task_manager/views/taskCompletedScreen/task_completed_screen.dart';
import 'package:task_manager/views/taskProgressScreen/task_progress_screen.dart';
import 'package:task_manager/views/widgets/fallback_widget.dart';

import '../newTaskAddScreen/new_task_add_screen.dart';
import '../widgets/app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController pageController;
  late SharedPreferences? preferences;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
      appBar: getApplicationAppBar(context: context, disableNavigation: false),
      body: Consumer<ConnectivityChecker>(
        builder: (_, viewModel, __) {
          if (viewModel.isDeviceConnected) {
            return PageView.builder(
              onPageChanged: (int value) {
                context.read<DashboardViewModel>().setIndex = value;
                context.read<TaskViewModel>().removeBadgeCount(
                    value, context.read<DashboardViewModel>());
              },
              controller: pageController,
              itemCount: screens.length,
              itemBuilder: (context, index) {
                return screens[index];
              },
            );
          }
          return const Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    FallbackWidget(
                        noDataMessage: "Ooppss No Internet",
                        asset: AppAssets.noInternet),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<DashboardViewModel>(
        builder: (context, viewModel, child) {
          return SalomonBottomBar(
            currentIndex: viewModel.index,
            onTap: (index) {
              if (context.read<ConnectivityChecker>().isDeviceConnected) {
                pageController.jumpToPage(index);
              }
              viewModel.setIndex = index;
              context.read<TaskViewModel>().removeBadgeCount(index, viewModel);
            },
            items: [
              SalomonBottomBarItem(
                  icon: Badge(
                    backgroundColor: AppColor.appPrimaryColor,
                    textColor: Colors.white,
                    isLabelVisible: (context
                            .read<TaskViewModel>()
                            .getBadgeCount(AppStrings.taskStatusNew)! >
                        0),
                    label: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(context
                          .read<TaskViewModel>()
                          .getBadgeCount(AppStrings.taskStatusNew)
                          .toString()),
                    ),
                    child: const Icon(Icons.add),
                  ),
                  title: const Text(AppStrings.taskStatusNew),
                  selectedColor: AppColor.appPrimaryColor,
                  unselectedColor:
                      (context.read<ThemeChanger>().getThemeMode(context) ==
                              ThemeMode.dark)
                          ? Colors.white
                          : Colors.black),
              SalomonBottomBarItem(
                  icon: Badge(
                    backgroundColor: AppColor.appPrimaryColor,
                    textColor: Colors.white,
                    isLabelVisible: (context
                            .read<TaskViewModel>()
                            .getBadgeCount(AppStrings.taskStatusProgress)! >
                        0),
                    label: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(context
                          .read<TaskViewModel>()
                          .getBadgeCount(AppStrings.taskStatusProgress)
                          .toString()),
                    ),
                    child: const Icon(Icons.watch_later_outlined),
                  ),
                  title: const Text(AppStrings.taskStatusProgress),
                  selectedColor: AppColor.appPrimaryColor,
                  unselectedColor:
                      (context.read<ThemeChanger>().getThemeMode(context) ==
                              ThemeMode.dark)
                          ? Colors.white
                          : Colors.black),
              SalomonBottomBarItem(
                  icon: Badge(
                    backgroundColor: AppColor.appPrimaryColor,
                    textColor: Colors.white,
                    isLabelVisible: (context
                            .read<TaskViewModel>()
                            .getBadgeCount(AppStrings.taskStatusCompleted)! >
                        0),
                    label: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(context
                          .read<TaskViewModel>()
                          .getBadgeCount(AppStrings.taskStatusCompleted)
                          .toString()),
                    ),
                    child: const Icon(Icons.done_outline_rounded),
                  ),
                  title: const Text(AppStrings.taskStatusCompleted),
                  selectedColor: AppColor.appPrimaryColor,
                  unselectedColor:
                      (context.read<ThemeChanger>().getThemeMode(context) ==
                              ThemeMode.dark)
                          ? Colors.white
                          : Colors.black),
              SalomonBottomBarItem(
                  icon: Badge(
                    backgroundColor: AppColor.appPrimaryColor,
                    textColor: Colors.white,
                    isLabelVisible: (context
                            .read<TaskViewModel>()
                            .getBadgeCount(AppStrings.taskStatusCanceled)! >
                        0),
                    label: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(context
                          .read<TaskViewModel>()
                          .getBadgeCount(AppStrings.taskStatusCanceled)
                          .toString()),
                    ),
                    child: const Icon(Icons.cancel_outlined),
                  ),
                  title: const Text(AppStrings.taskStatusCanceled),
                  selectedColor: AppColor.appPrimaryColor,
                  unselectedColor:
                      (context.read<ThemeChanger>().getThemeMode(context) ==
                              ThemeMode.dark)
                          ? Colors.white
                          : Colors.black),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    context.read<ConnectivityChecker>().disableInternetConnectionChecker();
    super.dispose();
  }
}

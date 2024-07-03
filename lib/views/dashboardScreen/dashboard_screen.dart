import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/viewModels/dashboard_view_model.dart';
import 'package:task_manager/viewModels/task_view_model.dart';
import 'package:task_manager/views/taskCancelledScreen/task_cancelled_screen.dart';
import 'package:task_manager/views/taskCompletedScreen/task_completed_screen.dart';
import 'package:task_manager/views/taskProgressScreen/task_progress_screen.dart';

import '../newTaskAddScreen/new_task_add_screen.dart';
import '../widgets/app_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController pageController;

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
      body: PageView.builder(
          onPageChanged: (int value) {
            context.read<DashboardViewModel>().setIndex = value;
          },
          controller: pageController,
          itemCount: screens.length,
          itemBuilder: (context, index) {
            return screens[index];
          }),
      bottomNavigationBar: Consumer<DashboardViewModel>(
        builder: (context, viewModel, child) {
          return SalomonBottomBar(
            currentIndex: viewModel.index,
            onTap: (index) {
              if ((index - viewModel.index) > 1 ||
                  (index - viewModel.index) < -1) {
                pageController.jumpToPage(index);
              } else {
                pageController.animateToPage(index,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 400));
              }
              viewModel.setIndex = index;
              context.read<TaskViewModel>().removeBadgeCount(index, viewModel);
            },
            items: [
              SalomonBottomBarItem(
                icon: Badge(
                  backgroundColor: AppColor.appPrimaryColor,
                  textColor: Colors.white,
                  isLabelVisible: (context.read<TaskViewModel>().getBadgeCount("New")! > 0),
                  label: Text(context
                      .read<TaskViewModel>()
                      .getBadgeCount("New")
                      .toString()),
                  child: const Icon(Icons.add),
                ),
                title: const Text("New Task"),
                selectedColor: AppColor.appPrimaryColor,
              ),
              SalomonBottomBarItem(
                icon: Badge(
                  backgroundColor: AppColor.appPrimaryColor,
                  textColor: Colors.white,
                  isLabelVisible: (context.read<TaskViewModel>().getBadgeCount("Progress")! > 0),
                  label: Text(context
                      .read<TaskViewModel>()
                      .getBadgeCount("Progress")
                      .toString()),
                  child: const Icon(Icons.watch_later_outlined),
                ),
                title: const Text("Progress"),
                selectedColor: AppColor.appPrimaryColor,
              ),
              SalomonBottomBarItem(
                icon: Badge(
                  backgroundColor: AppColor.appPrimaryColor,
                  textColor: Colors.white,
                  isLabelVisible: (context.read<TaskViewModel>().getBadgeCount("Completed")! > 0),
                  label: Text(context
                      .read<TaskViewModel>()
                      .getBadgeCount("Completed")
                      .toString()),
                  child: const Icon(Icons.done_outline_rounded),
                ),
                title: const Text("Completed"),
                selectedColor: AppColor.appPrimaryColor,
              ),
              SalomonBottomBarItem(
                icon: Badge(
                  backgroundColor: AppColor.appPrimaryColor,
                  textColor: Colors.white,
                  isLabelVisible: (context.read<TaskViewModel>().getBadgeCount("Canceled")! > 0),
                  label: Text(context
                      .read<TaskViewModel>()
                      .getBadgeCount("Canceled")
                      .toString()),
                  child: const Icon(Icons.cancel_outlined),
                ),
                title: const Text("Canceled"),
                selectedColor: AppColor.appPrimaryColor,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

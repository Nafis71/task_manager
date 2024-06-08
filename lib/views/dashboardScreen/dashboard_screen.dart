import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/utils/app_assets.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/dashboard_view_model.dart';
import 'package:task_manager/viewModels/user_view_model.dart';
import 'package:task_manager/views/taskAddScreen/task_add_screen.dart';
import 'package:task_manager/views/taskCancelledScreen/task_cancelled_screen.dart';
import 'package:task_manager/views/taskCompletedScreen/task_completed_screen.dart';
import 'package:task_manager/views/taskProgressScreen/task_progress_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> bottomBarIcons = const [
    Icon(Icons.watch_later_outlined, size: 25),
    Icon(Icons.done_all, size: 25),
    Icon(Icons.cancel_outlined, size: 25),
    Icon(Icons.add, size: 25),
  ];
  List<String> bottomBarLabels = [
    AppStrings.bottomBarProgress,
    AppStrings.bottomBarCompleted,
    AppStrings.bottomBarCanceled,
    AppStrings.bottomBarAdd,
  ];
  late final List<BottomNavigationBarItem> bottomNavigationBarItem;

  @override
  void initState() {
    bottomNavigationBarItem = List.generate(
      4,
      (index) => BottomNavigationBarItem(
        icon: bottomBarIcons[index],
        label: bottomBarLabels[index],
      ),
    );
    super.initState();
  }

  List<Widget> screens = const [
    TaskProgressScreen(),
    TaskCompletedScreen(),
    TaskCancelledScreen(),
    TaskAddScreen(),
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
      bottomNavigationBar: Consumer<DashboardViewModel>(
        builder: (context, viewModel, child) {
          return BottomNavigationBar(
            enableFeedback: true,
            useLegacyColorScheme: false,
            elevation: 0,
            type: BottomNavigationBarType.shifting,
            showUnselectedLabels: false,
            selectedItemColor: AppColor.bottomBarSelectedColor,
            unselectedItemColor: AppColor.bottomBarUnselectedColor,
            backgroundColor: AppColor.bottomBarBackgroundColor,
            selectedFontSize: 12,
            currentIndex: viewModel.index,
            onTap: (value) {
              viewModel.setIndex = value;
            },
            items: bottomNavigationBarItem,
          );
        },
      ),
    );
  }
}

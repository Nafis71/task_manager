import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_strings.dart';
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

  List<Widget> screens = const [
    TaskProgressScreen(),
    TaskAddScreen(),
    TaskCompletedScreen(),
    TaskCancelledScreen()
  ];

  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: false,
        selectedItemColor: AppColor.appPrimaryColor,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        currentIndex: myIndex,
        onTap: (value){
          myIndex = value;
          setState(() {

          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.call_missed_outgoing,size: 25,), label: AppStrings.bottomBarProgress,),
          BottomNavigationBarItem(icon: Icon(Icons.add,size: 25,), label: AppStrings.bottomBarAdd,),
          BottomNavigationBarItem(icon: Icon(Icons.done_all,size: 25),label: AppStrings.bottomBarCompleted,),
          BottomNavigationBarItem(icon: Icon(Icons.cancel_outlined,size: 25),label: AppStrings.bottomBarCanceled,)
        ],
      ),
    );
  }
}

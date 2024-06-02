import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/routes.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: (routeSettings){
        return Routes.generateRoute(routeSettings);
      },
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
      ),
    );
  }
}

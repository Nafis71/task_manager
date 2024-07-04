import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/themes/app_elevated_button_style.dart';
import 'package:task_manager/themes/app_text_style.dart';
import 'package:task_manager/themes/app_textfield_style.dart';
import 'package:task_manager/themes/appbar_style.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_routes.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';
import 'package:task_manager/viewModels/countdown_timer_view_model.dart';
import 'package:task_manager/viewModels/dashboard_view_model.dart';
import 'package:task_manager/viewModels/task_view_model.dart';
import 'package:task_manager/viewModels/user_view_model.dart';

class TaskManager extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => CountdownTimerViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        onGenerateRoute: (routeSettings) {
          return AppRoutes.generateRoute(routeSettings);
        },
        theme: ThemeData(
            useMaterial3: false,
            scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
            textTheme: AppTextStyle.getTextStyle(),
            inputDecorationTheme: AppTextFieldStyle.getTextFieldTheme(),
            elevatedButtonTheme:
                AppElevatedButtonStyle.getElevatedButtonStyle(),
            appBarTheme: AppbarStyle.getAppbarStyle()),
      ),
    );
  }
}

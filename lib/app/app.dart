import 'package:device_preview_minus/device_preview_minus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/themes/app_elevated_button_style.dart';
import 'package:task_manager/themes/app_text_style.dart';
import 'package:task_manager/themes/app_textfield_style.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/app_routes.dart';
import 'package:task_manager/viewModels/authentication_view_model.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> AuthenticationViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: (routeSettings){
          return AppRoutes.generateRoute(routeSettings);
        },
        theme: ThemeData(
          scaffoldBackgroundColor: AppColor.scaffoldBackgroundColor,
          textTheme: AppTextStyle.getTextStyle(),
          inputDecorationTheme: AppTextFieldStyle.getTextFieldTheme(),
          elevatedButtonTheme: AppElevatedButtonStyle.getElevatedButtonStyle(),
        ),
      ),
    );
  }
}

import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/app/app.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? theme = preferences.getString("themeMode");
  theme ??= "system";
  runApp(
    DevicePreview(
      builder: (_) => TaskManager(
        userTheme: theme!,
      ),
    ),
  );
}

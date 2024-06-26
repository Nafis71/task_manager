import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/app/app.dart';

main() {
  runApp(DevicePreview(builder: (_)=>const TaskManager()));
}

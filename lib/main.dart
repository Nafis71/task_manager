import 'package:device_preview_minus/device_preview_minus.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/app/app.dart';

main(){
  runApp(DevicePreview(builder: (_) => const TaskManager()));
}
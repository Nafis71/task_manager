import 'package:flutter/material.dart';

class TaskCompletedScreen extends StatefulWidget {
  const TaskCompletedScreen({super.key});

  @override
  State<TaskCompletedScreen> createState() => _TaskCompletedScreenState();
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Task completed Screen"),
      ),
    );
  }
}

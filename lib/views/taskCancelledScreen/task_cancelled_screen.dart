import 'package:flutter/material.dart';

class TaskCancelledScreen extends StatefulWidget {
  const TaskCancelledScreen({super.key});

  @override
  State<TaskCancelledScreen> createState() => _TaskCancelledScreenState();
}

class _TaskCancelledScreenState extends State<TaskCancelledScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Task cancelled Screen"),
      ),
    );
  }
}

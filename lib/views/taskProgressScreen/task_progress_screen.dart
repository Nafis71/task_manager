import 'package:flutter/material.dart';

class TaskProgressScreen extends StatefulWidget {
  const TaskProgressScreen({super.key});

  @override
  State<TaskProgressScreen> createState() => _TaskProgressScreenState();
}

class _TaskProgressScreenState extends State<TaskProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Progress Screen"),),
    );
  }
}

import 'package:task_manager/models/taskListModel/task_data.dart';

class TaskListModel {
  String? status;
  List<TaskData>? taskData;

  TaskListModel({this.status, this.taskData});

  TaskListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskData = <TaskData>[];
      json['data'].forEach((v) {
        taskData!.add(TaskData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskData != null) {
      data['data'] = taskData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
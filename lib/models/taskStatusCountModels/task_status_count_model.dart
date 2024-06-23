import 'package:task_manager/models/taskStatusCountModels/status_data.dart';

class TaskStatusCountModel {
  String? status;
  List<StatusData>? statusData;

  TaskStatusCountModel({this.status, this.statusData});

  TaskStatusCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      statusData = <StatusData>[];
      json['data'].forEach((v) {
        statusData!.add(StatusData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.statusData != null) {
      data['data'] = this.statusData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

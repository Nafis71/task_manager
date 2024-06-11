import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/models/taskListModel/task_list_model.dart';
import 'package:task_manager/models/taskStatusCountModels/task_status_count_model.dart';
import 'package:task_manager/utils/app_strings.dart';

import '../models/responseModel/response_code.dart';

class TaskService {
  late Object finalResponse;

  Future<Object> fetchTaskStatusCount(String token) async {
    try {
      Response response = await http.get(
        Uri.parse("${AppStrings.baseUrl}${AppStrings.taskStatusCountEndpoint}"),
        headers: {"token": token},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        finalResponse =
            Success(response: TaskStatusCountModel.fromJson(jsonData));
      } else {
        finalResponse = Failure(
            response.statusCode,
            ResponseCode.httpStatusMessages[response.statusCode] ??
                AppStrings.unknownResponseText);
      }
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse;
  }

  Future<Object> fetchTaskList(String taskStatus, String token) async {
    try {
      Response response = await http.get(
          Uri.parse(
              "${AppStrings.baseUrl}${AppStrings.listTaskByStatusEndpoint}/$taskStatus"),
          headers: {"token": token});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        finalResponse = Success(response: TaskListModel.fromJson(jsonData));
      } else {
        finalResponse = Failure(
            response.statusCode,
            ResponseCode.httpStatusMessages[response.statusCode] ??
                AppStrings.unknownResponseText);
      }
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse;
  }

  Future<Object> createTask(String token, Map<String, String> taskData) async {
    try {
      Response response = await http.post(
          Uri.parse("${AppStrings.baseUrl}${AppStrings.createTaskEndpoint}"),
          headers: {"content-type": "application/json", "token":token},
          body: jsonEncode(taskData));
      if (response.statusCode == 200) {
        finalResponse = Success();
      } else {
        finalResponse = Failure(
            response.statusCode,
            ResponseCode.httpStatusMessages[response.statusCode] ??
                AppStrings.unknownResponseText);
      }
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse;
  }

  Future<Object> deleteTask(String taskId, String token) async {
    try {
      Response response = await http.get(
          Uri.parse(
              "${AppStrings.baseUrl}${AppStrings.deleteTaskEndpoint}/$taskId"),
          headers: {"token": token});
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = jsonDecode(response.body);
        finalResponse = Success(response: jsonData["status"]);
      } else {
        finalResponse = Failure(
            response.statusCode,
            ResponseCode.httpStatusMessages[response.statusCode] ??
                AppStrings.unknownResponseText);
      }
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse;
  }
}

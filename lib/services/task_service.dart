import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/services/network_request.dart';
import 'package:task_manager/utils/app_strings.dart';

import '../models/responseModel/response_code.dart';

class TaskService {
  late Object finalResponse;

  Future<Object> fetchTaskStatusCount(String token) async {
    return finalResponse = await NetworkRequest.getRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.taskStatusCountEndpoint}",
      headers: {"token": token},
    );
  }

  Future<Object> fetchTaskList(String taskStatus, String token) async {
    return finalResponse = await NetworkRequest.getRequest(
      uri:
          "${AppStrings.baseUrl}${AppStrings.listTaskByStatusEndpoint}/$taskStatus",
      headers: {"token": token},
    );
  }

  Future<Object> createTask(String token, Map<String, String> taskData) async {
    try {
      Response response = await http.post(
          Uri.parse("${AppStrings.baseUrl}${AppStrings.createTaskEndpoint}"),
          headers: {"content-type": "application/json", "token": token},
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

  Future<Object> updateTask(
      String token, String taskId, String taskStatus) async {
    return finalResponse = await NetworkRequest.getRequest(
      uri:
          "${AppStrings.baseUrl}${AppStrings.updateTaskEndpoint}/$taskId/$taskStatus",
      headers: {"token": token},
    );
  }

  Future<Object> deleteTask(String taskId, String token) async {
    return finalResponse = await NetworkRequest.getRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.deleteTaskEndpoint}/$taskId",
      headers: {"token": token},
    );
  }
}

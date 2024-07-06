import 'package:task_manager/services/network_request.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/auth_view_model.dart';

class TaskService extends AuthViewModel {
  Future<Object> fetchTaskStatusCount(String token) async {
    return await NetworkRequest().getRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.taskStatusCountEndpoint}",
      headers: {"token": token},
    );
  }

  Future<Object> fetchTaskList(String taskStatus, String token) async {
    return await NetworkRequest().getRequest(
      uri:
          "${AppStrings.baseUrl}${AppStrings.listTaskByStatusEndpoint}/$taskStatus",
      headers: {"token": token},
    );
  }

  Future<Object> createTask(String token, Map<String, String> taskData) async {
    return await NetworkRequest().postRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.createTaskEndpoint}",
      body: taskData,
      headers: {"content-type": "application/json", "token": token},
    );
  }

  Future<Object> updateTask(
      String token, String taskId, String taskStatus) async {
    return await NetworkRequest().getRequest(
      uri:
          "${AppStrings.baseUrl}${AppStrings.updateTaskEndpoint}/$taskId/$taskStatus",
      headers: {"token": token},
    );
  }

  Future<Object> deleteTask(String taskId, String token) async {
    return await NetworkRequest().getRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.deleteTaskEndpoint}/$taskId",
      headers: {"token": token},
    );
  }
}

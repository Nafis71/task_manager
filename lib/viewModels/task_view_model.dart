import 'package:flutter/foundation.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/models/taskListModel/task_data.dart';
import 'package:task_manager/models/taskListModel/task_list_model.dart';
import 'package:task_manager/models/taskStatusCountModels/task_status_count_model.dart';
import 'package:task_manager/services/task_service.dart';
import '../models/taskStatusCountModels/status_data.dart';

class TaskViewModel extends ChangeNotifier {
  List<StatusData> _taskStatusData = [];
  Map<String, List<TaskData>> _taskDataByStatus = {};
  Map<String, String> taskStatusCount = {};
  Map<String, int> selectedIndex = {};
  bool _isLoading = false;
  bool _shouldRefresh = false;
  late Object response;
  TaskService taskService = TaskService();

  bool get isLoading => _isLoading;

  bool get shouldRefresh => _shouldRefresh;

  void setShouldRefresh(bool value) {
    _isLoading = value;
    _shouldRefresh = value;
    notifyListeners();
  }

  List<StatusData> get taskStatusData => _taskStatusData;

  Map<String, List<TaskData>> get taskDataByStatus => _taskDataByStatus;

  Future<void> fetchTaskStatusData(String token) async {
    response = await taskService.fetchTaskStatusCount(token);
    if (response is Success) {
      TaskStatusCountModel taskStatusCountModel =
          (response as Success).response as TaskStatusCountModel;
      if (taskStatusCountModel.statusData != null &&
          taskStatusCountModel.statusData!.isNotEmpty) {
        _taskStatusData =
            List.from(taskStatusCountModel.statusData as Iterable);
        for (StatusData data in _taskStatusData) {
          if (data.sId != null) {
            taskStatusCount[data.sId.toString()] = data.sum.toString();
          }
        }
      }
    }
  }

  Future<void> fetchTaskList(String token, String taskStatus) async {
    response = await taskService.fetchTaskList(taskStatus, token);
    if (response is Success) {
      TaskListModel taskListModel =
          (response as Success).response as TaskListModel;
      if (taskListModel.taskData != null) {
        _taskDataByStatus[taskStatus] =
            List.from(taskListModel.taskData as Iterable);
        setShouldRefresh(false);
      }
    }
  }

  Future<bool> deleteTask(
      String token, String taskId, String taskStatus, int index) async {
    selectedIndex[taskStatus] = index;
    notifyListeners();
    response = await taskService.deleteTask(taskId, token);
    if (response is Success) {
      _taskDataByStatus[taskStatus]
          ?.removeWhere((taskData) => taskData.sId == taskId);
      selectedIndex[taskStatus] = -1;
      notifyListeners();
      return true;
    } else {
      selectedIndex[taskStatus] = -1;
      notifyListeners();
      return false;
    }
  }
}

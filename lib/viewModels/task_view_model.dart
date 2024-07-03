import 'package:flutter/foundation.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/models/taskListModel/task_data.dart';
import 'package:task_manager/models/taskListModel/task_list_model.dart';
import 'package:task_manager/models/taskStatusCountModels/task_status_count_model.dart';
import 'package:task_manager/services/task_service.dart';
import 'package:task_manager/utils/app_strings.dart';
import 'package:task_manager/viewModels/dashboard_view_model.dart';
import '../models/taskStatusCountModels/status_data.dart';

class TaskViewModel extends ChangeNotifier {
  List<StatusData> _taskStatusData = [];
  List<String> taskList = [
    AppStrings.taskStatusNew,
    AppStrings.taskStatusCompleted,
    AppStrings.taskStatusProgress,
    AppStrings.taskStatusCanceled
  ];
  final Map<String, List<TaskData>> _taskDataByStatus = {};
  final Map<String, int> _badgeCount = {
    AppStrings.taskStatusNew: 0,
    AppStrings.taskStatusProgress: 0,
    AppStrings.taskStatusCompleted: 0,
    AppStrings.taskStatusCanceled: 0
  };
  Map<String, String> taskStatusCount = {};
  Map<String, int> selectedIndex = {};
  bool _isLoading = false;
  bool _shouldRefresh = false;
  late Object response;
  TaskService taskService = TaskService();

  bool get isLoading => _isLoading;

  bool get shouldRefresh => _shouldRefresh;

  List<StatusData> get taskStatusData => _taskStatusData;

  Map<String, List<TaskData>> get taskDataByStatus => _taskDataByStatus;

  int? getBadgeCount(String taskStatus) => _badgeCount[taskStatus];

  void setShouldRefresh(bool value) {
    _isLoading = value;
    _shouldRefresh = value;
    notifyListeners();
  }

  void setIsTileExpanded(String taskStatus, int index, bool value) {
    _taskDataByStatus[taskStatus]![index].isTileExpanded = value;
    notifyListeners();
  }

  Future<void> fetchTaskStatusData(String token) async {
    response = await taskService.fetchTaskStatusCount(token);
    if (response is Success) {
      TaskStatusCountModel taskStatusCountModel = TaskStatusCountModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if (taskStatusCountModel.statusData != null &&
          taskStatusCountModel.statusData!.isNotEmpty) {
        _taskStatusData =
            List.from(taskStatusCountModel.statusData as Iterable);
        taskStatusCount = {};
        for (StatusData data in _taskStatusData) {
          if (data.sId != null) {
            taskStatusCount[data.sId.toString()] = data.sum.toString();
          }
        }
      }
    }
  }

  Future<void> fetchTaskList(String token) async {
    for (String taskStatus in taskList) {
      response = await taskService.fetchTaskList(taskStatus, token);
      if (response is Success) {
        TaskListModel taskListModel = TaskListModel.fromJson(
            (response as Success).response as Map<String, dynamic>);
        if (taskListModel.taskData != null) {
          List<TaskData> taskData =
              List.from(taskListModel.taskData as Iterable);
          _taskDataByStatus[taskStatus] = taskData.reversed.toList();
        }
      }
    }
    notifyListeners();
  }

  Future<bool> createTask(
      String token, String taskSubject, String taskDescription) async {
    setShouldRefresh(true);
    Map<String, String> taskData = {
      "title": taskSubject,
      "description": taskDescription,
      "status": AppStrings.taskStatusNew
    };
    response = await taskService.createTask(token, taskData);
    if (response is Success) {
      setShouldRefresh(false);
      return true;
    }
    setShouldRefresh(false);
    return false;
  }

  Future<bool> updateTask({
    required String token,
    required String taskId,
    required String taskStatus,
    required String currentScreenStatus,
    required int index,
    required DashboardViewModel dashboardViewModel,
  }) async {
    setShouldRefresh(true);
    selectedIndex[currentScreenStatus] = index;
    response = await taskService.updateTask(token, taskId, taskStatus);
    if (response is Success) {
      List<TaskData>? tempData = _taskDataByStatus[currentScreenStatus]
          ?.where((taskData) => taskData.sId == taskId)
          .toList();
      if (tempData != null) {
        tempData[0].status = taskStatus;
        _taskDataByStatus[currentScreenStatus]!
            .removeWhere((taskData) => taskData.sId == taskId);
        _taskDataByStatus[taskStatus]?.add(tempData[0]);
        _taskDataByStatus[taskStatus]!.reversed.toList();
        selectedIndex[currentScreenStatus] = -1;
        int currentStatusCount =
            int.tryParse(taskStatusCount[currentScreenStatus]!) ?? 0;
        int targetStatusCount =
            int.tryParse(taskStatusCount[taskStatus].toString()) ?? 0;
        if (currentStatusCount != 0) {
          taskStatusCount[currentScreenStatus] =
              (currentStatusCount - 1).toString();
        }
        taskStatusCount[taskStatus] = (targetStatusCount + 1).toString();
      }
      _badgeCount[taskStatus] = (_badgeCount[taskStatus]! + 1);
      dashboardViewModel.refreshViewModel();
      setShouldRefresh(false);
      return true;
    }
    selectedIndex[currentScreenStatus] = -1;
    setShouldRefresh(false);
    return false;
  }

  void removeBadgeCount(int index, DashboardViewModel dashboardViewModel) {
    Map<int, String> taskIndex = {
      0: AppStrings.taskStatusNew,
      1: AppStrings.taskStatusProgress,
      2: AppStrings.taskStatusCompleted,
      3: AppStrings.taskStatusCanceled
    }; //it's placement is sync with index value of bottomNavBar
    _badgeCount[taskIndex[index]!] = 0;
    dashboardViewModel.refreshViewModel();
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
      taskStatusCount[taskStatus] =
          (int.parse(taskStatusCount[taskStatus].toString()) - 1).toString();
      notifyListeners();
      return true;
    } else {
      selectedIndex[taskStatus] = -1;
      notifyListeners();
      return false;
    }
  }
}

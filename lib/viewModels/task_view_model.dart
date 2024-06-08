import 'package:flutter/foundation.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/models/taskStatusCountModels/task_status_count_model.dart';
import 'package:task_manager/services/task_service.dart';
import '../models/taskStatusCountModels/status_data.dart';

class TaskViewModel extends ChangeNotifier{
  List<StatusData> _taskStatusData =[];
  Map<String,String> taskStatusCount ={};
  bool _isLoading = false;
  bool status = false;
  late Object response;
  TaskService taskService = TaskService();
  bool get isLoading => _isLoading;

  void setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }


  List<StatusData> get taskStatusData => _taskStatusData;

  Future<bool> fetchTaskStatusData(String token) async{
    status = false;
    response = await taskService.fetchTaskStatusCount(token);
    if(response is Success){
      TaskStatusCountModel taskStatusCountModel = (response as Success).response as TaskStatusCountModel;
      if(taskStatusCountModel.statusData != null && taskStatusCountModel.statusData!.isNotEmpty){
        _taskStatusData = List.from(taskStatusCountModel.statusData as Iterable);
        for(StatusData data in _taskStatusData){
          if(data.sId != null){
            taskStatusCount.putIfAbsent(data.sId.toString(), ()=> data.sum.toString());
          }
        }
      }
      setIsLoading(false);
      status = true;
    }
    return status;
  }


}
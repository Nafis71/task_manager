import 'package:flutter/foundation.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/models/taskStatusCountModels/task_status_count_model.dart';
import 'package:task_manager/services/task_service.dart';

import '../models/taskStatusCountModels/data.dart';

class TaskViewModel extends ChangeNotifier{
  List<Data> _taskStatusData =[];
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


  List<Data> get taskStatusData => _taskStatusData;

  Future<bool> fetchTaskStatusData(String token) async{
    status = false;
    response = await taskService.fetchTaskStatusCount(token);
    if(response is Success){
      TaskStatusCountModel taskStatusCountModel = (response as Success).response as TaskStatusCountModel;
      if(taskStatusCountModel.data != null && taskStatusCountModel.data!.isNotEmpty){
        _taskStatusData = List.from(taskStatusCountModel.data as Iterable);
        for(Data data in _taskStatusData){
          if(data.sId != null){
            taskStatusCount.putIfAbsent(data.sId.toString(), ()=> data.sum.toString());
          }
        }
      }
      setIsLoading(false);
      status = true;
      print(taskStatusCount);
    }
    return status;
  }


}
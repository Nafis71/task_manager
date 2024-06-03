import 'package:flutter/material.dart';
import 'package:task_manager/models/loginModels/user_data.dart';

class UserViewModel extends ChangeNotifier {
  late UserData _userData;

  UserData get userData => _userData;

  set setUserData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }
}

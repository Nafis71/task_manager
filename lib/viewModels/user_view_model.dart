import 'package:flutter/material.dart';
import 'package:task_manager/models/loginModels/user_data.dart';

class UserViewModel extends ChangeNotifier {
  String _token = "";
  UserData _userData = UserData(
    email: "",
    firstName: "",
    lastName: "",
    mobile: "",
    password: "",
  );

  UserData get userData => _userData;
  String get token => _token;

  set setToken(String token) => _token = token;

  set setUserData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }
}

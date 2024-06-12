import 'package:flutter/material.dart';
import 'package:task_manager/models/loginModels/user_data.dart';

class UserViewModel extends ChangeNotifier {
  String _token = "";
  bool _isLoading = false;
  UserData _userData = UserData(
    email: "",
    firstName: "",
    lastName: "",
    mobile: "",
    password: "",
  );

  bool get isLoading => _isLoading;
  UserData get userData => _userData;
  String get token => _token;

  set setToken(String token) => _token = token;
  set setIsLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  set setUserData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }
}

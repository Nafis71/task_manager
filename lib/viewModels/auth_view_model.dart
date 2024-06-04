import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/loginModels/login_model.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/services/auth_service.dart';
import '../models/loginModels/user_data.dart';

class AuthViewModel extends ChangeNotifier{
  bool _isPasswordObscured = true;
  bool _isLoading = false;
  bool status = false;
  late Object response;
  AuthService authService = AuthService();
  late SharedPreferences preferences;
  Map<String,String> resetPasswordInformation = {};

  bool get isPasswordObscure => _isPasswordObscured;
  bool get isLoading => _isLoading;

  void setLoading(value){
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> registerUser({required String email,
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required String password})async {
    status = false;
    setLoading(true);
    UserData userData =  UserData(
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobileNumber,
      password: password,
    );
    response = await authService.registration(userData);
    (response is Success) ? status = true : status = false;
    setLoading(false);
    return(status);
  }

  Future<bool> signInUser({required String email, required String password}) async{
    status = false;
    setLoading(true);
    response = await authService.signIn(email, password);
    if(response is Success) {
      LoginModel loginModel = (response as Success).response as LoginModel;
      status = true;
      preferences = await SharedPreferences.getInstance();
      saveUserData(loginModel);
    } else{
      status = false;
    }
    setLoading(false);
    return(status);
  }

  void saveUserData(LoginModel loginModel){
    preferences.setString("token", loginModel.token.toString());
    preferences.setString("email", loginModel.data!.email.toString());
    preferences.setString("firstName", loginModel.data!.firstName.toString());
    preferences.setString("lastName", loginModel.data!.lastName.toString());
    preferences.setString("mobile", loginModel.data!.mobile.toString());
    preferences.setString("photo", loginModel.data!.photo.toString());
  }

  set setPasswordObscure(bool value){
    _isPasswordObscured = value;
    notifyListeners();
  }
}
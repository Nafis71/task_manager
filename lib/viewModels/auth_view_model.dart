import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/loginModels/login_model.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/viewModels/user_view_model.dart';
import '../models/loginModels/user_data.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isPasswordObscured = true;
  bool _isLoading = false;
  bool finalStatus = false;
  String _recoveryEmail = "";
  String _OTP = "";
  late Object response;
  AuthService authService = AuthService();
  late SharedPreferences preferences;
  Map<String, String> resetPasswordInformation = {};

  bool get isPasswordObscure => _isPasswordObscured;

  bool get isLoading => _isLoading;

  void setLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> registerUser(
      {required String email,
      required String firstName,
      required String lastName,
      required String mobileNumber,
      required String password}) async {
    finalStatus = false;
    setLoading(true);
    UserData userData = UserData(
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobileNumber,
      password: password,
    );
    response = await authService.registration(userData);
    (response is Success) ? finalStatus = true : finalStatus = false;
    setLoading(false);
    return (finalStatus);
  }

  Future<bool> signInUser(
      {required String email, required String password, required UserViewModel userViewModel}) async {
    finalStatus = false;
    setLoading(true);
    response = await authService.signIn(email, password);
    if (response is Success) {
      LoginModel loginModel = LoginModel.fromJson((response as Success).response as Map<String,dynamic>);
      finalStatus = true;
      preferences = await SharedPreferences.getInstance();
      saveUserData(loginModel,userViewModel,password);
    } else {
      finalStatus = false;
    }
    setLoading(false);
    return (finalStatus);
  }

  Future<bool> sendOTP(String email) async {
    finalStatus = false;
    setLoading(true);
    response = await authService.requestOTP(email);
    if (response is Success) {
      Map<String,dynamic> status = (response as Success).response as Map<String,dynamic>;
      if (status['status'] == "success") {
        _recoveryEmail = email;
        setLoading(false);
        return true;
      }
    }
    setLoading(false);
    return false;
  }

  Future<bool> verifyOTP(String otp) async {
    finalStatus = false;
    setLoading(true);
    response = await authService.verifyOTP(otp, _recoveryEmail);
    if (response is Success) {
      Map<String,dynamic> status = (response as Success).response as Map<String,dynamic>;
      if (status['status'] == "success") {
        setLoading(false);
        _OTP = otp;
        finalStatus = true;
      }
    }
    setLoading(false);
    return finalStatus;
  }

  Future<bool> resetPassword(String newPassword) async {
    finalStatus = false;
    setLoading(true);
    resetPasswordInformation.putIfAbsent("email", () => _recoveryEmail);
    resetPasswordInformation.putIfAbsent("OTP", () => _OTP);
    resetPasswordInformation.putIfAbsent("password", () => newPassword);
    response = await authService.resetPassword(resetPasswordInformation);
    if (response is Success) {
      Map<String,dynamic> status = (response as Success).response as Map<String,dynamic>;
      if (status["status"] == "success") {
        resetPasswordInformation = {};
        setLoading(false);
        finalStatus = true;
      }
    }
    setLoading(false);
    return finalStatus;
  }

  void saveUserData(LoginModel loginModel,UserViewModel userViewModel,String password) {
    preferences.setString("token", loginModel.token.toString());
    preferences.setString("email", loginModel.data!.email.toString());
    preferences.setString("firstName", loginModel.data!.firstName.toString());
    preferences.setString("lastName", loginModel.data!.lastName.toString());
    preferences.setString("mobile", loginModel.data!.mobile.toString());
    preferences.setString("photo", loginModel.data!.photo.toString());
    preferences.setString("password", password);
    userViewModel.setToken = loginModel.token.toString();
    userViewModel.setUserData = UserData(
      email: loginModel.data!.email.toString(),
      firstName: loginModel.data!.firstName.toString(),
      lastName: loginModel.data!.lastName.toString(),
      mobile: loginModel.data!.mobile.toString(),
      photo: loginModel.data!.photo.toString(),
      password: password,
    );
  }

  set setPasswordObscure(bool value) {
    _isPasswordObscured = value;
    notifyListeners();
  }
}

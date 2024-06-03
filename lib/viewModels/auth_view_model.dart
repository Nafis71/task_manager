import 'package:flutter/foundation.dart';
import 'package:task_manager/services/auth_service.dart';

import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier{
  bool _isPasswordObscured = true;
  AuthService authService = AuthService();

  bool get isPasswordObscure => _isPasswordObscured;


  Future<bool> registerUser({required String email,
    required String firstName,
    required String lastName,
    required String mobileNumber,
    required String password})async {
    UserModel userModel =  UserModel(
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobileNumber,
      password: password,
    );
    try{
      await authService.registration(userModel);
    }catch(e){
      if(kDebugMode){
        debugPrint(e.toString());
        return false;
      }
    }
    return true;
  }

  set setPasswordObscure(bool value){
    _isPasswordObscured = value;
    notifyListeners();
  }
}
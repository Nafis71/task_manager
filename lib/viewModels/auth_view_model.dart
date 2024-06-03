import 'package:flutter/foundation.dart';
import 'package:task_manager/services/auth_service.dart';

import '../models/user_model.dart';

class AuthViewModel extends ChangeNotifier{
  bool _isPasswordObscured = true;
  bool _isLoading = false;
  AuthService authService = AuthService();

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
    bool status = false;
    setLoading(true);
    UserModel userModel =  UserModel(
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobileNumber,
      password: password,
    );
    try{
      status = await authService.registration(userModel);
    }catch(e){
      if(kDebugMode){
        debugPrint(e.toString());
        setLoading(false);
        status = false;
      }
    }finally{
      setLoading(false);
    }
    return(status);
  }

  set setPasswordObscure(bool value){
    _isPasswordObscured = value;
    notifyListeners();
  }
}
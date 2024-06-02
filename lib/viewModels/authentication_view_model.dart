import 'package:flutter/material.dart';

class AuthenticationViewModel extends ChangeNotifier{
  bool _isPasswordObscured = true;

  bool get isPasswordObscure => _isPasswordObscured;

  set setPasswordObscure(bool value){
    _isPasswordObscured = value;
    notifyListeners();
  }
}
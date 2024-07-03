import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/loginModels/user_data.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/services/user_info_service.dart';

import '../models/loginModels/login_model.dart';

class UserViewModel extends ChangeNotifier {
  String _token = "";
  bool _isLoading = false;
  bool _isPasswordObscured = true;
  final ImagePicker _pickedImage = ImagePicker();
  String imageName = "";
  String base64Image = "";
  late Object response;
  UserData _userData = UserData(
    email: "",
    firstName: "",
    lastName: "",
    mobile: "",
    password: "",
  );

  bool get isPasswordObscured => _isPasswordObscured;

  bool get isLoading => _isLoading;

  UserData get userData => _userData;

  String get token => _token;

  set setIsPasswordObscured(bool value){
    _isPasswordObscured = value;
    notifyListeners();
  }

  set setToken(String token) => _token = token;

  set setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  set setUserData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }

  Future<void> loadUserData(SharedPreferences preferences) async {
    setToken = preferences.getString("token")!;
    setUserData =
        UserData.fromJson(jsonDecode(preferences.getString("userData")!));
  }

  void saveUserData(
      LoginModel loginModel, SharedPreferences preferences, String password) {
    loginModel.data!.password = password;
    preferences.setString("token", loginModel.token.toString());
    preferences.setString("userData", jsonEncode(loginModel.data!.toJson()));
    setToken = loginModel.token.toString();
    setUserData = loginModel.data!;
  }

  Future<void> getImageFromGallery() async {
    XFile? pickedFile = await _pickedImage.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      imageName = pickedFile.name;
      convertImage(pickedFile);
      notifyListeners();
    }
  }

  Future<bool> updateUserData({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    required String password,
  }) async {
    setIsLoading = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (_userData.photo!.isNotEmpty && base64Image.isEmpty) {
      base64Image = preferences.getString("photo").toString();
    }
    UserData userData = UserData(
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      password: password,
      photo: base64Image,
    );
    response = await UserInfoService.updateUserProfile(token, userData);
    if (response is Success) {
      _userData = userData;
      preferences.setString("email", email);
      preferences.setString("firstName", firstName);
      preferences.setString("lastName", lastName);
      preferences.setString("mobile", mobile);
      preferences.setString("photo", base64Image);
      preferences.setString("password", password);
      base64Image = "";
      imageName = "";
      setIsLoading = false;
      return true;
    }
    base64Image = "";
    imageName = "";
    setIsLoading = false;
    return false;
  }

  void convertImage(XFile pickedFile) {
    List<int> imageBytes = File(pickedFile.path).readAsBytesSync();
    base64Image = base64Encode(imageBytes);
  }
}

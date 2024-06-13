import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/models/loginModels/user_data.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/services/user_info_service.dart';

class UserViewModel extends ChangeNotifier {
  String _token = "";
  bool _isLoading = false;
  final ImagePicker _pickedImage = ImagePicker();
  String imageName ="";
  late Object response;
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
  String base64Image = "";

  set setToken(String token) => _token = token;
  set setIsLoading(bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }

  set setUserData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }

  Future<void> getImageFromGallery() async{
    XFile? pickedFile = await _pickedImage.pickImage(source: ImageSource.gallery,imageQuality: 80,);
    if(pickedFile != null){
      imageName = pickedFile.name;
      convertImage(pickedFile);
      notifyListeners();
    }
  }
  Future<bool> updateUserData(
      {required String email,
      required String firstName,
      required String lastName,
      required String mobile,
      required String password,
      }) async{
    setIsLoading = true;
    UserData userData = UserData(
      email: email,
      firstName: firstName,
      lastName: lastName,
      mobile: mobile,
      password: password,
      photo: base64Image,
    );
    print(base64Image);
    response = await UserInfoService.updateUserProfile(token, userData);
    if(response is Success){
      _userData = userData;
      print(base64Image);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("email", email);
      preferences.setString("firstName", firstName);
      preferences.setString("lastName", lastName);
      preferences.setString("mobile", mobile);
      preferences.setString("photo", base64Image);
      preferences.setString("password", password);
      setIsLoading = false;
      return true;
    }
    setIsLoading = false;
    return false;
  }
  void convertImage(XFile pickedFile){
    List<int> imageBytes = File(pickedFile.path).readAsBytesSync();
    base64Image = base64Encode(imageBytes);
  }
}

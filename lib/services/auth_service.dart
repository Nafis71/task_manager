import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:task_manager/models/user_model.dart';
import 'package:task_manager/utils/app_strings.dart';

class AuthService {
  Future<void> registration(UserModel userModel) async {
    Response response = await http.post(
        Uri.parse("${AppStrings.baseUrl}/${AppStrings.registrationEndpoint}"),
        body: jsonEncode(userModel.toJson()),
        headers: {'content-type': 'application/json'});
    if(response.statusCode != 200){
      throw Exception("Failed to register user, ${response.statusCode}");
    }
  }
}

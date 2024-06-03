import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:task_manager/models/loginModels/user_data.dart';
import 'package:task_manager/utils/app_strings.dart';

class AuthService {
  Future<bool> registration(UserData userData) async {
    Response response = await http.post(
        Uri.parse("${AppStrings.baseUrl}${AppStrings.registrationEndpoint}"),
        body: jsonEncode(userData.toJson()),
        headers: {'content-type': 'application/json'});
    if(response.statusCode == 200){
      return true;
    }
    throw Exception("Failed to register user, ${response.statusCode}");
  }
}

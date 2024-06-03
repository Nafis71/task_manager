import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:task_manager/models/loginModels/login_model.dart';
import 'package:task_manager/models/loginModels/user_data.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/models/responseModel/response_code.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/utils/app_strings.dart';

class AuthService {
  late Object finalResponse;

  Future<Object> registration(UserData userData) async {
    try {
      Response response = await http.post(
          Uri.parse("${AppStrings.baseUrl}${AppStrings.registrationEndpoint}"),
          body: jsonEncode(userData.toJson()),
          headers: {"content-type": "application/json"});
      if (response.statusCode == 200) {
        finalResponse = Success();
      } else {
        finalResponse = Failure(
            response.statusCode,
            ResponseCode.httpStatusMessages[response.statusCode] ??
                AppStrings.unknownResponseText);
        throw Exception("Failed to register user, ${response.statusCode}");
      }
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
    }
    return finalResponse;
  }

  Future<Object> signIn(String email, String password) async {
    try {
      Map<String, String> signInCredentials = {
        "email": email,
        "password": password,
      };
      Response response = await http.post(
          Uri.parse("${AppStrings.baseUrl}${AppStrings.signInEndpoint}"),
          body: jsonEncode(signInCredentials),
          headers: {"content-type": "application/json"});
      if (response.statusCode == 200) {
        Map<String,dynamic> jsonData = jsonDecode(response.body);
        finalResponse = Success(response: LoginModel.fromJson(jsonData));
      } else {
        finalResponse = Failure(
            response.statusCode,
            ResponseCode.httpStatusMessages[response.statusCode] ??
                AppStrings.unknownResponseText);
        throw Exception("Failed to register user, ${response.statusCode}");
      }
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
    }
    return finalResponse;
  }
}

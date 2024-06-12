import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/models/loginModels/user_data.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/utils/app_strings.dart';

import '../models/responseModel/response_code.dart';

class UserInfoService {
  late Object finalResponse;

  Future<Object> updateUserProfile(String token, UserData userData) async {
    try {
      Response response = await http.post(
        Uri.parse("${AppStrings.baseUrl}${AppStrings.profileUpdateEndpoint}"),
        headers: {"content-type": "application/json", "token": token},
        body: jsonEncode(userData),
      );
      if(response.statusCode == 200){
        finalResponse = Success();
      } else {
        finalResponse = Failure(
            response.statusCode,
            ResponseCode.httpStatusMessages[response.statusCode] ??
                AppStrings.unknownResponseText);
      }
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse;
  }
}

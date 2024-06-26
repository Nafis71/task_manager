import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/utils/app_navigation.dart';
import '../models/responseModel/response_code.dart';
import '../utils/app_strings.dart';

class NetworkRequest {
  static Object? finalResponse;

  static Future<Object> getRequest(
      {required String uri, Map<String, String>? headers, bool shouldAuthenticate = true}) async {
    try {
      Response response = await get(Uri.parse(uri), headers: headers);
      finalResponse = getResponse(response,shouldAuthenticate: shouldAuthenticate);
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse!;
  }

  static Future<Object> postRequest(
      {required String uri,
      Map<String, String>? headers,
      required Map<String, dynamic> body}) async {
    try {
      Response response =
          await post(Uri.parse(uri), headers: headers, body: jsonEncode(body));
      finalResponse = getResponse(response);
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse!;
  }

  static Object getResponse(Response response, {bool shouldAuthenticate = true}) {
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Success(response: jsonData);
    } else if(shouldAuthenticate && response.statusCode == 401){
      AppNavigation().signOutUser();
      return Failure(401, AppStrings.sessionExpiredText);
    } else {
      return Failure(
          response.statusCode,
          ResponseCode.httpStatusMessages[response.statusCode] ??
              AppStrings.unknownResponseText);
    }
  }
}

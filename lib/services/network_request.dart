import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/models/responseModel/success.dart';
import 'package:task_manager/utils/app_navigation.dart';

import '../models/responseModel/response_code.dart';
import '../utils/app_strings.dart';

class NetworkRequest {
  Object? finalResponse;
  static NetworkRequest? instance;

  NetworkRequest._();

  factory NetworkRequest() {
    return instance ??= NetworkRequest._();
  }

  Future<Object> getRequest(
      {required String uri,
      Map<String, String>? headers,
      bool shouldAuthenticateToken = true}) async {
    try {
      Response response = await get(Uri.parse(uri), headers: headers);
      finalResponse = getResponse(response,
          shouldAuthenticateToken: shouldAuthenticateToken);
    } on ClientException {
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse!;
  }

  Future<Object> postRequest(
      {required String uri,
      Map<String, String>? headers,
      required Map<String, dynamic> body,
      bool shouldAuthenticateToken = true}) async {
    try {
      Response response =
          await post(Uri.parse(uri), headers: headers, body: jsonEncode(body));
      finalResponse = getResponse(response,
          shouldAuthenticateToken: shouldAuthenticateToken);
    } on ClientException {
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse!;
  }

  Object getResponse(Response response, {bool shouldAuthenticateToken = true}) {
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Success(response: jsonData);
    } else if (shouldAuthenticateToken && response.statusCode == 401) {
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

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:task_manager/models/responseModel/failure.dart';
import 'package:task_manager/models/responseModel/success.dart';

import '../models/responseModel/response_code.dart';
import '../utils/app_strings.dart';

class NetworkRequest {
  static late Object finalResponse;

  static Future<Object> getRequest(
      {required String uri, Map<String, String>? headers}) async {
    try {
      Response response = await get(Uri.parse(uri), headers: headers);
      finalResponse = getResponse(response);
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse;
  }
  static Future<Object> postRequest(
      {required String uri, Map<String, String>? headers,required Map<String,dynamic> body}) async {
    try {
      Response response = await post(Uri.parse(uri), headers: headers,body: jsonEncode(body));
      finalResponse = getResponse(response);
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
      finalResponse = Failure(600, AppStrings.unknownResponseText);
    }
    return finalResponse;
  }
  static Object getResponse(Response response){
    if(response.statusCode == 200){
      final jsonData = jsonDecode(response.body);
      return Success(response: jsonData);
    } else{
      return Failure(
          response.statusCode,
          ResponseCode.httpStatusMessages[response.statusCode] ??
              AppStrings.unknownResponseText);
    }
  }
}

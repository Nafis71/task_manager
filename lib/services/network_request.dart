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
      if(response.statusCode == 200){
        final jsonData = jsonDecode(response.body);
        finalResponse = Success(response: jsonData);
      } else{
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

import 'package:task_manager/utils/app_strings.dart';

class ResponseCode {
  static Map<int, String> httpStatusMessages = {
    // Informational Responses
    200: "Successful request",
    400:
        "The request could not be understood by the server due to malformed syntax",
    401: AppStrings.signInFailureMessage,
    403: "The server understood the request but refused to fulfill it",
    404: "The requested resource could not be found",
    500:
        "A generic error message, given when an unexpected condition was encountered and no more specific message is suitable",
    503:
        "The server is currently unable to handle the request due to temporary overloading or maintenance of the server",
  };
}

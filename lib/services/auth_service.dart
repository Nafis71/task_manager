import 'package:task_manager/models/loginModels/user_data.dart';
import 'package:task_manager/services/network_request.dart';
import 'package:task_manager/utils/app_strings.dart';

class AuthService{
  Future<Object> registration(UserData userData) async {
    return await NetworkRequest.postRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.registrationEndpoint}",
      body: userData.toJson(),
      headers: {"content-type": "application/json"},
    );
  }

  Future<Object> signIn(String email, String password) async {
    Map<String, String> signInCredentials = {
      "email": email,
      "password": password,
    };
    return await NetworkRequest.postRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.signInEndpoint}",
      body: signInCredentials,
      headers: {"content-type": "application/json"},
    );
  }

  Future<Object> requestOTP(String email) async {
    return await NetworkRequest.getRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.recoverEmailEndpoint}/$email",
    );
  }

  Future<Object> verifyOTP(String otp, String email) async {
    return await NetworkRequest.getRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.verifyOTPEndpoint}/$email/$otp",
    );
  }

  Future<Object> resetPassword(Map<String, String> data) async {
    return await NetworkRequest.postRequest(
      uri: "${AppStrings.baseUrl}${AppStrings.resetPasswordEndpoint}",
      body: data,
      headers: {"content-type": "application/json"},
    );
  }
}

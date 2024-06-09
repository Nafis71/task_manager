class AppStrings {
  //api credentials
  static const String baseUrl = "https://task.teamrabbil.com/api/v1/";
  static const String registrationEndpoint = "registration";
  static const String signInEndpoint = "login";
  static const String recoverEmailEndpoint = "RecoverVerifyEmail";
  static const String verifyOTPEndpoint = "RecoverVerifyOTP";
  static const String resetPasswordEndpoint = "RecoverResetPass";
  static const String taskStatusCountEndpoint = "taskStatusCount";
  static const String listTaskByStatusEndpoint = "listTaskByStatus";
  static const String deleteTaskEndpoint = "deleteTask";
  static const String unknownResponseText = "Unknown Error";

  //regularExpression
  static const String nameRegEX = r'^[a-z A-Z]+$';
  static const String digitsRegEx = r'^[0-9]+$';
  static const String emailRegEx =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  //bottomNavigationBar
  static const String bottomBarProgress = "Progress";
  static const String bottomBarCompleted = "Completed";
  static const String bottomBarCanceled = "Canceled";
  static const String bottomBarAdd = "New Task";

  static const String emailTextFieldHint = "Email";
  static const String passwordTextFieldHint = "Password";
  static const String firstNameTextFieldHint = "First Name";
  static const String lastNameTextFieldHint = "Last Name";
  static const String confirmPassTextFieldHint = "Confirm Password";
  static const String mobileNumberTextFieldHint = "Mobile";
  static const String signInHeaderText = "Get Started With";
  static const String obscuringChar = "*";
  static const String forgetPasswordText = "Forget Password?";
  static const String signInBottomTextOne = "Don't have account?";
  static const String signInBottomTextTwo = " Sign up";
  static const String signUpBottomTextOne = "Have account? ";
  static const String signUpBottomTextTwo = "Sign in";
  static const String signUpHeaderText = "Join With Us";
  static const String emailErrorText = "Invalid email address";
  static const String passwordErrorText = "Invalid password";
  static const String passwordLengthErrorText =
      "Please give at least 8 characters";
  static const String confirmPasswordErrorText = "Password didn't match";
  static const String firstNameErrorText = "Invalid first name";
  static const String lastNameErrorText = "Invalid last name";
  static const String mobileNumberErrorText = "Invalid mobile number";
  static const String emailVerificationHeaderText = "Your Email Address";
  static const String emailVerificationBodyText =
      "A 6 digit verification pin will send to your email address";
  static const String pinVerificationHeaderText = "Pin Verification";
  static const String pinVerificationBodyText =
      "A 6 digit verification pin will send to your email address";
  static const String pinVerificationButtonText = "Verify";
  static const String setPasswordHeaderText = "Set Password";
  static const String setPasswordBodyText =
      "Minimum length password 8 character with letter and number combination";
  static const String setPasswordButtonText = "Confirm";

  //registration SnackBar
  static const String signInFailureTitle = "Login Failed";
  static const String signInFailureMessage = "Please use correct credentials";
  static const String registrationSuccessTitle = "Success!";
  static const String registrationFailureTitle = "Oops!";
  static const String registrationSuccessMessage =
      "You have been registered successfully";
  static const String registrationFailureMessage =
      "Something went wrong, try again later";
  static const String sendOTPFailureTitle = "Failed!";
  static const String sendOTPFailureMessage = "No user found with this email!";
  static const String emptyPinVerificationFieldTitle = "Invalid Pin";
  static const String wrongPinVerificationFieldTitle = "Wrong Pin";
  static const String emptyPinVerificationFieldMessage =
      "Please insert all fields";
  static const String wrongPinVerificationFieldMessage =
      "Enter correct pin and try again";
  static const String resetPasswordFailureTitle = "Failed!";
  static const String resetPasswordSuccessTitle = "Success!";
  static const String resetPasswordSuccessMessage =
      "Your password has been reset successfully";
  static const String taskItemDeleteSuccessTitle = "Success!";
  static const String taskItemDeleteFailedTitle = "Failed!";
  static const String taskItemDeleteSuccessMessage =
      "Task has been deleted successfully";
  static const String taskItemDeleteFailureMessage =
      "Item failed to delete, try again";

  //noData
  static const String noNewTaskData = "Your new task list is currently empty";
  static const String noNewCanceledData =
      "Your canceled task list is currently empty";
}

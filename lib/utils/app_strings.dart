class AppStrings {
  //api credentials
  static const String baseUrl = "https://task.teamrabbil.com/api/v1/";
  static const String registrationEndpoint = "registration";
  static const String signInEndpoint = "login";
  static const String unknownResponseText = "Unknown Error";

  //regularExpression
  static const String nameRegEX = r'^[a-z A-Z]+$';
  static const String digitsRegEx = r'^[0-9]+$';
  static const String emailRegEx =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

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
}

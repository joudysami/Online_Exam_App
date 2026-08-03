class AppString {
  AppString._();

  static const String home = 'Home';
  static const String welcome = 'Welcome';
  static const String continueText = 'Continue';
  static const String resend = 'Resend';
  static const String password = 'Password';

  // Login
  static const String login = 'Login';
  static const String email = 'Email';
  static const String enterYourEmail = 'Enter your email';
  static const String enterYourPassword = 'Enter your password';
  static const String rememberMe = 'Remember me';
  static const String forgotPassword = 'Forgot Password?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String signUp = 'Sign Up';

  //Sign Up
  static const String signupButton = 'Signup';
  static const String userName = 'User name';
  static const String enterYourUserName = 'Enter your user name';
  static const String firstName = 'First name';
  static const String enterYourFirstName = 'Enter your first name';
  static const String lastName = 'Last name';
  static const String enterYourLastName = 'Enter your last name';
  static const String confirmPassword = 'Confirm Password';
  static const String confirmPasswordHint = 'Confirm password';
  static const String phoneNumber = 'Phone Number';
  static const String enterYourPhoneNumber = 'Enter your phone number';
  static const String alreadyHaveAccount = 'Already have an account? ';

  // Forget Password
  static const String forgetPasswordTitle = 'Forget password';
  static const String forgetPasswordSubtitle =
      'Please enter your email associated to\nyour account';

  // Email Verification
  static const String emailVerificationTitle = 'Email verification';
  static const String emailVerificationSubtitle =
      'Please enter your code that send to your\nemail address';
  static const String invalidCode = 'Invalid code';
  static const String didntReceiveCode = "Didn't receive code? ";

  // Reset Password
  static const String resetPasswordTitle = 'Reset password';
  static const String resetPasswordSubtitle =
      'Password must not be empty and must contain\n6 characters with upper case letter and one\nnumber at least';
  static const String newPassword = 'New password';
  static const String passwordResetSuccessfully =
      'Password reset successfully!';

  // Validators
  static const String pleaseEnterYourEmail = 'Please enter your email';
  static const String pleaseEnterValidEmail = 'Please enter a valid email';
  static const String passwordIsRequired = 'Password is required';
  static const String passwordRequirement =
      'Password must be 8+ chars and 1 uppercase letter';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String phoneNumberIsRequired = 'Phone number is required';
  static const String validEgyptianPhone =
      'Enter a valid Egyptian phone number';
  static const String resetPasswordRequirement =
      'Password must contain at least 6 characters, one uppercase letter and one number';
  static const String onlyLettersNumbersUnderscore =
      'Only letters, numbers and _ are allowed';

  static String fieldIsRequired(String field) => '$field is required';
  static String fieldMinLength(String field, int length) =>
      '$field must be at least $length characters';
  static String fieldNoSpaces(String field) => '$field cannot contain spaces';

  // Home Feature
  static const String explore = 'Explore';
  static const String result = 'Result';
  static const String profile = 'Profile';
  static const String survey = 'Survey';
  static const String search = 'Search';
  static const String browseBySubject = 'Browse by subject';
  static const String question = 'Question';
  static String questionsCount(dynamic count) => '$count Question';
  static const String startExam = 'Start Exam';
  static const String instructions = 'Instructions';
  static const String duration = 'Duration';
  static const String highLevel = 'High-level ';
}



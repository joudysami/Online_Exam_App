class AppValidators {
  AppValidators._();

 static String? usernameValidator(String? value, {String field = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return "$field is required";
    }
    if (value.length < 4) {
      return "$field must be at least 4 characters";
    }
    if (value.contains(" ")) {
      return "$field cannot contain spaces";
    }
    final regex = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!regex.hasMatch(value)) {
      return "Only letters, numbers and _ are allowed";
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
     return 'Please enter your email';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Z]).{8,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be 8+ chars and 1 uppercase letter';
    }
    return null;
  }

  static String? confirmPasswordValidator(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    final regex = RegExp(r'^01[0125][0-9]{8}$');
    if (!regex.hasMatch(value)) {
      return "Enter a valid Egyptian phone number";
    }
    return null;
  }
}

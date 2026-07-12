sealed class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  ForgetPasswordSuccess(this.message);
}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  ForgetPasswordError(this.message);
}

// Verify Code States
class VerifyCodeLoading extends ForgetPasswordState {}

class VerifyCodeSuccess extends ForgetPasswordState {}

class VerifyCodeError extends ForgetPasswordState {
  final String message;
  VerifyCodeError(this.message);
}

// Reset Password States
class ResetPasswordLoading extends ForgetPasswordState {}

class ResetPasswordSuccess extends ForgetPasswordState {}

class ResetPasswordError extends ForgetPasswordState {
  final String message;
  ResetPasswordError(this.message);
}
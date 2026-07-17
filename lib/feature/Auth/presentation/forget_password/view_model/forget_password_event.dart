sealed class ForgetPasswordEvent {}
 class ForgetPassword extends ForgetPasswordEvent{
  final String email;
  ForgetPassword(this.email);
 }
  class ResetPassword extends ForgetPasswordEvent{
    final String newPassword;
  ResetPassword(this.newPassword);
  }
  class EmailVerification extends ForgetPasswordEvent{
    final String code;
  EmailVerification(this.code);
  }
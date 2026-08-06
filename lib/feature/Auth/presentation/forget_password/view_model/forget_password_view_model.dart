import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/domain/usecase/forget_password_usecase.dart';
import 'package:exam_app/feature/Auth/domain/usecase/verify_code_usecase.dart';
import 'package:exam_app/feature/Auth/domain/usecase/reset_password_usecase.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  String email = '';

  ForgetPasswordViewModel(
    this.forgetPasswordUseCase,
    this.verifyCodeUseCase,
    this.resetPasswordUseCase,
  ) : super(const ForgetPasswordState());
  void doEvent(ForgetPasswordEvent event) {
    switch (event) {
      case ForgetPassword():
        _forgotPassword(event.email);
        break;
      case ResetPassword():
        _resetPassword(event.newPassword);
        break;
      case EmailVerification():
        _verifyCode(event.code);
        break;
        case ClearVerifyCodeError():
        _clearVerifyCodeError();
    }
  }

  Future<void> _forgotPassword(String email) async {
    this.email = email;
    emit(
      state.copyWith(
        forgetPasswordState: state.forgetPasswordState.copyWith(
          isLoading: true,
        ),
      ),
    );
    final response = await forgetPasswordUseCase(email);
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
            forgetPasswordState: state.forgetPasswordState.copyWith(
              isLoading: false,
              data: (response as SuccessResponse).data,
              errorMessage: '',
            ),
          ),
        );
        break;
      case ErrorResponse<String>():
        emit(
          state.copyWith(
            forgetPasswordState: state.forgetPasswordState.copyWith(
              isLoading: false,
              errorMessage: (response as ErrorResponse).errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _verifyCode(String code) async {
    emit(
      state.copyWith(
        verifyCodeState: state.verifyCodeState.copyWith(
          isLoading: true,
        ),
      ),
    );
    final response = await verifyCodeUseCase(code);
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
              verifyCodeState: state.verifyCodeState.copyWith(
              isLoading: false,
              data: (response as SuccessResponse).data,
              errorMessage: '',
            ),
          ),
        );
        break;
      case ErrorResponse<String>():
        emit(
          state.copyWith(
            verifyCodeState: state.verifyCodeState.copyWith(
              isLoading: false,
              errorMessage: (response as ErrorResponse).errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _resetPassword(String newPassword) async {
    emit(
      state.copyWith(
        resetPasswordState: state.resetPasswordState.copyWith(
          isLoading: true,
        ),
      ),
    );
    final response = await resetPasswordUseCase(email, newPassword);
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
            resetPasswordState: state.resetPasswordState.copyWith(
              isLoading: false,
              data: (response as SuccessResponse).data,
              errorMessage: '',
            ),
          ),
        );
        break;
      case ErrorResponse<String>():
        emit(
          state.copyWith(
            resetPasswordState: state.resetPasswordState.copyWith(
              isLoading: false,
              errorMessage: (response as ErrorResponse).errorMessage,
            ),
          ),
        );
    }
  }
 void _clearVerifyCodeError() {
  emit(
    state.copyWith(
      verifyCodeState: state.verifyCodeState.copyWith(
        errorMessage: '',
      ),
    ),
  );
}
}

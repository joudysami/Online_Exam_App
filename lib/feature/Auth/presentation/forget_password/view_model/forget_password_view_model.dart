import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/domain/usecase/forget_password_usecase.dart';
import 'package:exam_app/feature/Auth/domain/usecase/verify_code_usecase.dart';
import 'package:exam_app/feature/Auth/domain/usecase/reset_password_usecase.dart';
import '../state/forget_password_state.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  String _email = '';

  ForgetPasswordViewModel(
    this._forgetPasswordUseCase,
    this._verifyCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(ForgetPasswordInitial());

  Future<void> forgotPassword(String email) async {
    _email = email;
    emit(ForgetPasswordLoading());
    final response = await _forgetPasswordUseCase(email);
    if (response is SuccessResponse<String>) {
      emit(ForgetPasswordSuccess(response.data));
    } else if (response is ErrorResponse<String>) {
      emit(ForgetPasswordError(response.errorMessage));
    }
  }

  Future<void> verifyCode(String code) async {
    emit(VerifyCodeLoading());
    final response = await _verifyCodeUseCase(code);
    if (response is SuccessResponse<String>) {
      emit(VerifyCodeSuccess());
    } else if (response is ErrorResponse<String>) {
      emit(VerifyCodeError(response.errorMessage));
    }
  }

  Future<void> resetPassword(String newPassword) async {
    emit(ResetPasswordLoading());
    final response = await _resetPasswordUseCase(_email, newPassword);
    if (response is SuccessResponse<String>) {
      emit(ResetPasswordSuccess());
    } else if (response is ErrorResponse<String>) {
      emit(ResetPasswordError(response.errorMessage));
    }
  }
}
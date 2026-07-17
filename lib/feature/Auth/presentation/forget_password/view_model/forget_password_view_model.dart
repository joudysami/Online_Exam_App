import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/domain/usecase/forget_password_usecase.dart';
import 'package:exam_app/feature/Auth/domain/usecase/verify_code_usecase.dart';
import 'package:exam_app/feature/Auth/domain/usecase/reset_password_usecase.dart';


@injectable
class ForgetPasswordViewModel extends Cubit<BaseState<AuthEntity>> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  String email = '';

  ForgetPasswordViewModel(
    this.forgetPasswordUseCase,
    this.verifyCodeUseCase,
    this.resetPasswordUseCase,
  ) : super(BaseState<AuthEntity>());
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
    }
  }

  Future<void> _forgotPassword(String email) async {
    this.email = email;
      emit(
  state.copyWith(
    isLoading: true,
    errorMessage: '',
  ),);
    final response = await forgetPasswordUseCase(email);
    if (response is SuccessResponse<String>) {
     emit(
  state.copyWith(
    isLoading: false,
    data: (response as SuccessResponse).data,
    errorMessage: '',
  ),);
    } else if (response is ErrorResponse<String>) {
    emit(
  state.copyWith(
    isLoading: false,
    errorMessage:(response as ErrorResponse).errorMessage,
  ),
);  
    }
  }

  Future<void> _verifyCode(String code) async {
     emit(
  state.copyWith(
    isLoading: true,
    errorMessage: '',
  ),);
    final response = await verifyCodeUseCase(code);
    if (response is SuccessResponse<String>) {
     emit(
  state.copyWith(
    isLoading: false,
    data: (response as SuccessResponse).data,
    errorMessage: '',
  ),);
    } else if (response is ErrorResponse<String>) {
    emit(
  state.copyWith(
    isLoading: false,
    errorMessage:(response as ErrorResponse).errorMessage,
  ),
);  
    }
  }

  Future<void> _resetPassword(String newPassword) async {
   emit(
  state.copyWith(
    isLoading: true,
    errorMessage: '',
  ),);
    final response = await resetPasswordUseCase(email, newPassword);
    if (response is SuccessResponse<String>) {
       emit(
  state.copyWith(
    isLoading: false,
    data: (response as SuccessResponse).data,
    errorMessage: '',
  ),);
    } else if (response is ErrorResponse<String>) {
      emit(
  state.copyWith(
    isLoading: false,
    errorMessage:(response as ErrorResponse).errorMessage,
  ),
);  
    }
  }
}

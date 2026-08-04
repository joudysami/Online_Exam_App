import 'package:exam_app/feature/Auth/presentation/sign_up/view_model/sign_up_event.dart';
import 'package:exam_app/feature/Auth/presentation/sign_up/view_model/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';
import 'package:exam_app/feature/Auth/domain/usecase/sign_up_usecase.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel(this._signUpUseCase) : super(const SignUpState());
  void doEvent(SignUpEvent event) {
    switch (event) {
      case SingUp():
        _signUp(event.request);
    }
  }

  Future<void> _signUp(SignUpRequest request) async {
    emit(
      state.copyWith(
        signUpState: state.signUpState.copyWith(
          isLoading: true,
          errorMessage: "",
        ),
      ),
    );
    final response = await _signUpUseCase(request);

    switch (response) {
      case SuccessResponse<AuthEntity>():
        emit(
          state.copyWith(
            signUpState: state.signUpState.copyWith(
              isLoading: false,
              data: (response as SuccessResponse).data,
              errorMessage: '',
            ),
          ),
        );
        break;
      case ErrorResponse<AuthEntity>():
        emit(
          state.copyWith(
            signUpState: state.signUpState.copyWith(
              isLoading: false,
              errorMessage: (response as ErrorResponse).errorMessage,
            ),
          ),
        );
    }
  }
}

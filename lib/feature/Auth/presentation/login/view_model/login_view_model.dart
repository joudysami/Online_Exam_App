import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';
import 'package:exam_app/feature/Auth/presentation/login/view_model/login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/login_request.dart';
import 'package:exam_app/feature/Auth/domain/usecase/login_usecase.dart';

@injectable
class LoginViewModel extends Cubit<BaseState<AuthEntity>> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(BaseState<AuthEntity>());
  void doEvent(LoginEvent event) {
    switch (event) {
      case Login():
        _login(event.email, event.password);
        break;
    }
  }

  Future<void> _login(String email, String password) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final request = LoginRequest(email: email, password: password);
    final response = await _loginUseCase(request);

    if (response is SuccessResponse) {
      emit(
        state.copyWith(
          isLoading: false,
          data: (response as SuccessResponse).data,
          errorMessage: '',
        ),
      );
    } else if (response is ErrorResponse) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: (response as ErrorResponse).errorMessage,
        ),
      );
    }
  }
}

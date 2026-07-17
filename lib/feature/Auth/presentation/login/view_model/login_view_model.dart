import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/login_request.dart';
import 'package:exam_app/feature/Auth/domain/usecase/login_usecase.dart';
import 'package:exam_app/feature/Auth/presentation/login/state/login_state.dart';

@injectable
class LoginViewModel extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final request = LoginRequest(email: email, password: password);
    final response = await _loginUseCase(request);

    if (response is SuccessResponse) {
      emit(LoginSuccess((response as SuccessResponse).data));
    } else if (response is ErrorResponse) {
      emit(LoginError((response as ErrorResponse).errorMessage));
    }
  }
}
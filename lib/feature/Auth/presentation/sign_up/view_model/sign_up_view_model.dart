import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';
import 'package:exam_app/feature/Auth/domain/usecase/sign_up_usecase.dart';
import '../state/sign_up_state.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel(this._signUpUseCase) : super(SignUpInitial());

  Future<void> signUp(SignUpRequest request) async {
    emit(SignUpLoading());
    final response = await _signUpUseCase(request);
    
    if (response is SuccessResponse<AuthEntity>) {
      emit(SignUpSuccess());
    } else if (response is ErrorResponse<AuthEntity>) {
      emit(SignUpError(response.errorMessage));
    }
  }
}

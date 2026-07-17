import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Auth/presentation/sign_up/view_model/sign_up_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';
import 'package:exam_app/feature/Auth/domain/usecase/sign_up_usecase.dart';

@injectable
class SignUpViewModel extends Cubit<BaseState<AuthEntity>> {
  final SignUpUseCase _signUpUseCase;

  SignUpViewModel(this._signUpUseCase) : super(BaseState<AuthEntity>());
 void doEvent(SignUpEvent event){
  switch(event){
    
    case SingUp():
      _signUp(event.request);
  }
 }
  Future<void> _signUp(SignUpRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: ""));
    final response = await _signUpUseCase(request);

    if (response is SuccessResponse<AuthEntity>) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "",
          data: response .data,
        ),
      );
    } else if (response is ErrorResponse<AuthEntity>) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: response .errorMessage,
        ),
      );
    }
  }
}

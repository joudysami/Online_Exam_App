import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';

class SignUpState {
 final BaseState<AuthEntity> signUpState;

  const SignUpState({
    this.signUpState = const BaseState(),
  });

  SignUpState copyWith({
    BaseState<AuthEntity>? signUpState,
  }) {
    return SignUpState(
      signUpState: signUpState ?? this.signUpState,
    );
  }
}


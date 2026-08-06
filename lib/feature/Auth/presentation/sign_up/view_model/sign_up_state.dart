import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';

class SignUpState extends Equatable {
  @override
  List<Object?> get props => [signUpState];
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


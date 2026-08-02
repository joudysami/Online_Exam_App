import 'package:equatable/equatable.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [loginState];

 final BaseState<AuthEntity> loginState;

  const LoginState({
    this.loginState = const BaseState(),
  });

  LoginState copyWith({
    BaseState<AuthEntity>? loginState,
  }) {
    return LoginState(
      loginState: loginState ?? this.loginState,
    );
  }
  

}


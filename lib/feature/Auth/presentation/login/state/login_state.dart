import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthEntity authEntity;

  LoginSuccess(this.authEntity);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
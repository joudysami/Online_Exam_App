import 'package:exam_app/config/base/base_state.dart';

class ForgetPasswordState {
  final BaseState<String> forgetPasswordState;
  final BaseState<String> verifyCodeState;
  final BaseState<String> resetPasswordState;

  const ForgetPasswordState({
    this.forgetPasswordState = const BaseState(),
    this.verifyCodeState = const BaseState(),
    this.resetPasswordState = const BaseState(),
  });

  ForgetPasswordState copyWith({
    BaseState<String>? forgetPasswordState,
    BaseState<String>? verifyCodeState,
    BaseState<String>? resetPasswordState,
  }) {
    return ForgetPasswordState(
      forgetPasswordState:
          forgetPasswordState ?? this.forgetPasswordState,
      verifyCodeState:
          verifyCodeState ?? this.verifyCodeState,
      resetPasswordState:
          resetPasswordState ?? this.resetPasswordState,
    );
  }
}
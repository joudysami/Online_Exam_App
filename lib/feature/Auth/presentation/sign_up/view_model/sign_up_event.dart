import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';

sealed class SignUpEvent {}

class SingUp extends SignUpEvent {
  final SignUpRequest request;

  SingUp(this.request);
}
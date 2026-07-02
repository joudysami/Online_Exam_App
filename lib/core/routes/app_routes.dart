import 'package:exam_app/core/routes/app_routes_named.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/screens/forget_password_screen.dart';
import 'package:exam_app/feature/Auth/presentation/login/view/screen/login_screen.dart';
import 'package:exam_app/feature/Auth/presentation/sign_up/view/screen/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNamed.login:
        return MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        );

      case AppRoutesNamed.signup:
        return MaterialPageRoute(
          builder: (context) {
            return SignUpScreen();
          },
        );
      case AppRoutesNamed.forgetPassword:
        return MaterialPageRoute(
          builder: (context) {
            return ForgetPasswordScreen();
          },
        );
      default:
        return MaterialPageRoute(
          builder: (context) {
            return Container();
          },
        );
    }
  }
}

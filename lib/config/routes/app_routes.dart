import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/email_verification_screen.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/forget_password_screen.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/reset_password_screen.dart';
import 'package:exam_app/feature/Auth/presentation/login/view/login_screen.dart';
import 'package:exam_app/feature/Auth/presentation/sign_up/view/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutesNamed.login,
    routes: [
      GoRoute(
        path: AppRoutesNamed.login,
        name: AppRoutesNamed.login,
        builder: (context, state) => const LoginScreen(),
      ),
        GoRoute(
        path: AppRoutesNamed.signup,
        name: AppRoutesNamed.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
        GoRoute(
        path: AppRoutesNamed.forgetPassword,
        name: AppRoutesNamed.forgetPassword,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
        GoRoute(
        path: AppRoutesNamed.emailVerification,
        name: AppRoutesNamed.emailVerification,
        builder: (context, state) => const EmailVerificationScreen(),
      ),
       GoRoute(
        path: AppRoutesNamed.resetPassword,
        name: AppRoutesNamed.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),



       ///we need edit later///



      //  GoRoute(
      //   path: AppRoutesNamed.emailVerification,
      //   name: AppRoutesNamed.emailVerification,
      //   builder: (context, state) => const EmailVerificationScreen(),
      // ),
      //  GoRoute(
      //   path: AppRoutesNamed.profile,
      //   name: AppRoutesNamed.profile,
      //   builder: (context, state) => const EmailVerificationScreen(),
      // ),
      //  GoRoute(
      //   path: AppRoutesNamed.home,
      //   name: AppRoutesNamed.home,
      //   builder: (context, state) => const EmailVerificationScreen(),
      // ),
      //  GoRoute(
      //   path: AppRoutesNamed.emailVerification,
      //   name: AppRoutesNamed.emailVerification,
      //   builder: (context, state) => const EmailVerificationScreen(),
      // ),
      //  GoRoute(
      //   path: AppRoutesNamed.emailVerification,
      //   name: AppRoutesNamed.emailVerification,
      //   builder: (context, state) => const EmailVerificationScreen(),
      // ),
    ],
  );
}

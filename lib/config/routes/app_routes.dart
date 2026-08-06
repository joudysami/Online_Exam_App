import 'package:exam_app/config/Di/di.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/feature/Auth/data/datasource/local/auth_local_datasource.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/screens/email_verification_screen.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/screens/forget_password_screen.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/screens/reset_password_screen.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:exam_app/feature/Auth/presentation/login/view/login_screen.dart';
import 'package:exam_app/feature/Auth/presentation/sign_up/view/sign_up_screen.dart';
import 'package:exam_app/feature/Auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:exam_app/feature/Home/data/models/exam_details_args.dart';
import 'package:exam_app/feature/Home/presentation/exams/view/screens/exams_screen.dart';
import 'package:exam_app/feature/Home/presentation/exams/view/screens/start_exams_screen.dart';
import 'package:exam_app/feature/Home/presentation/exams/view_model/exam_event.dart';
import 'package:exam_app/feature/Home/presentation/exams/view_model/exam_view_model.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view/screens/home_screen.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view_model/subject_event.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view_model/subject_view_model.dart';
import 'package:exam_app/feature/Home/presentation/questions/view/screens/questions_screen.dart';
import 'package:exam_app/feature/Home/presentation/questions/view/screens/score_screen.dart';
import 'package:exam_app/feature/Home/presentation/questions/view_model/questions_view_model.dart';
import 'package:exam_app/feature/Home/domain/entity/score_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutesNamed.login,
    redirect: (context, state) {
    final token = getIt<AuthLocalDatasource>().getToken();

    final loggedIn = token != null && token.isNotEmpty;

    final isAuthPage =
        state.matchedLocation == AppRoutesNamed.login ||
        state.matchedLocation == AppRoutesNamed.signup;

    if (!loggedIn && !isAuthPage) {
      return AppRoutesNamed.login;
    }

    if (loggedIn && isAuthPage) {
      return AppRoutesNamed.home;
    }

    return null;
  },

    routes: [
      GoRoute(
        path: AppRoutesNamed.login,
        name: AppRoutesNamed.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutesNamed.signup,
        name: AppRoutesNamed.signup,
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<SignUpViewModel>(),
          child: const SignUpScreen(),
        ),
      ),

      // Forget Password flow - wrapped in a shared ShellRoute to share one Cubit
      ShellRoute(
        builder: (context, state, child) => BlocProvider(
          create: (_) => getIt<ForgetPasswordViewModel>(),
          child: child,
        ),
        routes: [
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
          GoRoute(
            path: AppRoutesNamed.questionsScreen,
            name: AppRoutesNamed.questionsScreen,
            builder: (context, state) {
              final args = state.extra as ExamDetailsArgs;
              return BlocProvider(
                create: (_) => getIt<QuestionsViewModel>(),
                child: QuestionsScreen(examId: args.examId ?? '', duration: args.duration ?? '30'),
              );
            },
          ),
          GoRoute(
            path: AppRoutesNamed.scoreScreen,
            name: AppRoutesNamed.scoreScreen,
            builder: (context, state) {
              final score = state.extra as ScoreEntity;
              return ScoreScreen(score: score);
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutesNamed.home,
        name: AppRoutesNamed.home,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    getIt<SubjectViewModel>()..doEvent(GetAllSubject()),
              ),
            ],
            child: const HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutesNamed.examDetails,
        name: AppRoutesNamed.examDetails,
        builder: (context, state) {
          final args = state.extra as ExamDetailsArgs;
          return BlocProvider(
            create: (_) =>
                getIt<ExamsViewModel>()
                  ..doEvent(GetAllExams(args.subjectId, args.subjectName)),
            child: ExamsScreen(
              subjectId: args.subjectId,
              subjectName: args.subjectName,
              subjectIcon: args.subjectIcon,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutesNamed.startExam,
        name: AppRoutesNamed.startExam,
        builder: (context, state) {
          final args = state.extra as ExamDetailsArgs;
          return BlocProvider(
            create: (_) =>
                getIt<ExamsViewModel>()
                  ..doEvent(GetAllExams(args.subjectId, args.subjectName)),
            child: StartExamScreen(
              examId: args.examId ?? '',
              subjectId: args.subjectId,
              subjectName: args.subjectName,
              subjectIcon: args.subjectIcon,
              duration: args.duration??"",
              numberOfQuestions: args.numberOfQuestions??"",
            ),
          );
        },
      ),
    ],
  );
}

import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/config/helpers/validator/app_validators.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_textfeild.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';
import 'package:exam_app/feature/Auth/presentation/login/view_model/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/config/Di/di.dart';
import '../view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  late final LoginViewModel loginViewModel = getIt<LoginViewModel>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(title: 'Login'),

        body: BlocProvider(
         create: (context) => loginViewModel,
          child: BlocConsumer<LoginViewModel, BaseState<AuthEntity>>(
            listener: (context, state) {
              if (state.data != null) {
                context.goNamed(AppRoutesNamed.home);
              } else if (state.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Email',
                        hint: 'Enter your email',
                        validator: AppValidators.emailValidator,
                        controller: _emailController,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        label: 'Password',
                        hint: 'Enter your password',
                        validator: AppValidators.passwordValidator,
                        controller: _passwordController,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: colors.blue,
                            side: BorderSide(color: colors.grey, width: 1.5.w),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                          ),
                          Text(
                            'Remember me',
                            style: TextStyle(
                              color: colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutesNamed.forgetPassword);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: colors.blue,
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: state.isLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: colors.blue,
                                ),
                              )
                            : CustomButton(
                                text: "Login",
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginViewModel.doEvent(
                                      Login(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      ),
                                    );
                                  }
                                },
                              ),
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(
                              color: colors.black,
                              fontSize: 15.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutesNamed.signup);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: colors.blue,
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

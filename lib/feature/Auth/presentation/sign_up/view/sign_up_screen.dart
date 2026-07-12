import 'package:exam_app/config/helpers/validator/app_validators.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_textfeild.dart';
import 'package:exam_app/feature/Auth/data/models/sign_up_request.dart';
import 'package:exam_app/feature/Auth/presentation/sign_up/state/sign_up_state.dart';
import 'package:exam_app/feature/Auth/presentation/sign_up/view_model/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _userNameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneNumberController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(title: 'Sign Up'),
      body: BlocConsumer<SignUpViewModel, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            context.goNamed(AppRoutesNamed.home);
          } else if (state is SignUpError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. User name
                    CustomTextField(
                      label: 'User name',
                      hint: 'Enter your user name',
                      validator: (value) =>
                          AppValidators.usernameValidator(value, field: 'userName'),
                      controller: _userNameController,
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'First name',
                            hint: 'Enter your first name',
                            validator: (value) => AppValidators.usernameValidator(
                              value,
                              field: 'firstName',
                            ),
                            controller: _firstNameController,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTextField(
                            label: 'Last name',
                            hint: 'Enter your last name',
                            validator: (value) => AppValidators.usernameValidator(
                              value,
                              field: 'lastName',
                            ),
                            controller: _lastNameController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    CustomTextField(
                      label: 'Email',
                      hint: 'Enter your email',
                      validator: AppValidators.emailValidator,
                      controller: _emailController,
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Password',
                            hint: 'Enter your password',
                            validator: AppValidators.passwordValidator,
                            controller: _passwordController,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomTextField(
                            label: 'Confirm Password',
                            hint: 'Confirm password',
                            validator: (value) {
                              return AppValidators.confirmPasswordValidator(
                                value,
                                _passwordController.text,
                              );
                            },
                            controller: _confirmPasswordController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    CustomTextField(
                      label: 'Phone Number',
                      hint: 'Enter your phone number',
                      validator: AppValidators.phoneValidator,
                      controller: _phoneNumberController,
                    ),

                    SizedBox(height: 48.h),

                    SizedBox(
                      width: double.infinity,
                      child: state is SignUpLoading
                          ? Center(
                              child: CircularProgressIndicator(color: colors.blue),
                            )
                          : CustomButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<SignUpViewModel>().signUp(
                                        SignUpRequest(
                                          username: _userNameController.text.trim(),
                                          firstName: _firstNameController.text.trim(),
                                          lastName: _lastNameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                          rePassword: _confirmPasswordController.text,
                                          phone: _phoneNumberController.text.trim(),
                                        ),
                                      );
                                }
                              },
                              text: "Signup",
                            ),
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: colors.black, fontSize: 15.sp),
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushNamed(AppRoutesNamed.login);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: colors.blue,
                              fontSize: 16.sp,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

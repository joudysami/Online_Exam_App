import 'package:exam_app/config/helpers/validator/app_validators.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneNumberController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _userNameController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. User name
              CustomTextField(
                label: 'User name',
                hint: 'Enter your user name',
                validator: (value) => AppValidators.usernameValidator(value),
                controller: _userNameController,
              ),
              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'First name',
                      hint: 'Enter your first name',
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomTextField(
                      label: 'Last name',
                      hint: 'Enter your last name',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              CustomTextField(
                label: 'Email',
                hint: 'Enter your email',
                validator: (value) => AppValidators.emailValidator(value),
                controller: _emailController,
              ),
              SizedBox(height: 16.h),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Password',
                      hint: 'Enter your password',
                      validator: (value) =>
                          AppValidators.passwordValidator(value),
                      controller: _passwordController,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomTextField(
                      label: 'Confirm Password',
                      hint: 'Confirm password',
                      validator: (value) =>
                          AppValidators.confirmPasswordValidator(
                            value,
                            _passwordController.text,
                          ),
                      controller: _confirmPasswordController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              CustomTextField(
                label: 'Phone Number',
                hint: 'Enter your phone number',
                validator: (value) => AppValidators.phoneValidator(value),
                controller: _phoneNumberController,
              ),

              SizedBox(height: 48.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     context.pushNamed(AppRoutesNamed.login);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: colors.white,
                    ),
                  ),
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
  }
}

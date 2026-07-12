import 'package:exam_app/config/helpers/validator/app_validators.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_textfeild.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/header_section.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/state/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          context.goNamed(AppRoutesNamed.login);
        } else if (state is ResetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colors.white,
          appBar: CustomAppBar(title: 'Password'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  const HeaderSection(
                    title: 'Reset password',
                    subtitle: 'Password must not be empty and must contain\n6 characters with upper case letter and one\nnumber at least',
                  ),
                  SizedBox(height: 32.h),
                  CustomTextField(
                    label: 'New password',
                    hint: 'Enter your password',
                    controller: _passwordController,
                    obscureText: true,
                    validator: AppValidators.resetPasswordValidator,
                  ),
                  SizedBox(height: 24.h),
                  CustomTextField(
                    label: 'Confirm password',
                    hint: 'Confirm password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (value) => AppValidators.confirmPasswordValidator(
                      value,
                      _passwordController.text,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  SizedBox(
                    width: double.infinity,
                    child: state is ResetPasswordLoading
                        ? Center(child: CircularProgressIndicator(color: colors.blue))
                        : CustomButton(
                            text: 'Continue',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ForgetPasswordViewModel>().resetPassword(
                                  _passwordController.text,
                                );
                              }
                            },
                          ),
                  ),
                  SizedBox(height: 32.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


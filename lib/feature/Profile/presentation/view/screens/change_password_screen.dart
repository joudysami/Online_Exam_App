import 'package:exam_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/config/Di/di.dart';
import 'package:exam_app/core/widgets/custom_textfeild.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/Profile/presentation/view_model/profile_view_model.dart';
import 'package:exam_app/feature/Profile/presentation/view_model/profile_event.dart';
import 'package:exam_app/feature/Profile/data/models/change_password_request.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileViewModel>(),
      child: const ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.white,
      appBar: const CustomAppBar(title: 'Reset password'),
      body: BlocConsumer<ProfileViewModel, ProfileState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: colors.error),
            );
          } else if (!state.isLoading && state.errorMessage.isEmpty && state.data == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password reset successfully'), backgroundColor: colors.success),
            );
            context.pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    hint: 'Current password',
                    label: 'Current password',
                    controller: _currentPasswordController,
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Please enter current password';
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hint: 'New password',
                    label: 'New password',
                    controller: _newPasswordController,
                    obscureText: true,
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Please enter new password';
                      if (val.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hint: 'Confirm password',
                    label: 'Confirm password',
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (val) {
                      if (val != _newPasswordController.text) return 'Password not matched';
                      return null;
                    },
                  ),
                  SizedBox(height: 30.h),
                  if (state.isLoading)
                    Center(child: CircularProgressIndicator(color: colors.blue))
                  else
                    CustomButton(
                      text: 'Update',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProfileViewModel>().doEvent(
                            ChangePasswordEvent(
                              ChangePasswordRequest(
                                oldPassword: _currentPasswordController.text,
                                password: _newPasswordController.text,
                                rePassword: _confirmPasswordController.text,
                              )
                            )
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

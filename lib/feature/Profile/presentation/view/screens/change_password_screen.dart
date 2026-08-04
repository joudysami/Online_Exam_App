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
import 'package:exam_app/core/constant/app_strings.dart';
import 'package:exam_app/core/utils/validators.dart';

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
      appBar: const CustomAppBar(title: AppStrings.resetPassword),
      body: BlocListener<ProfileViewModel, ProfileState>(
        listener: (context, state) {
          if (state.profileState.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.profileState.errorMessage), backgroundColor: colors.error),
            );
          } else if (!state.profileState.isLoading && state.profileState.errorMessage.isEmpty && state.profileState.data == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppStrings.updateProfileSuccess), backgroundColor: colors.success),
            );
            context.pop();
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTextField(
                    hint: AppStrings.currentPassword,
                    label: AppStrings.currentPassword,
                    controller: _currentPasswordController,
                    obscureText: true,
                    validator: (val) => Validators.validateRequired(val, AppStrings.currentPassword),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hint: AppStrings.newPassword,
                    label: AppStrings.newPassword,
                    controller: _newPasswordController,
                    obscureText: true,
                    validator: (val) => Validators.validatePassword(val),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    hint: AppStrings.confirmPassword,
                    label: AppStrings.confirmPassword,
                    controller: _confirmPasswordController,
                    obscureText: true,
                    validator: (val) => Validators.validateConfirmPassword(val, _newPasswordController.text),
                  ),
                  SizedBox(height: 30.h),
                  BlocBuilder<ProfileViewModel, ProfileState>(
                    builder: (context, state) {
                      if (state.profileState.isLoading) {
                        return Center(child: CircularProgressIndicator(color: colors.blue));
                      }
                      return CustomButton(
                        text: AppStrings.save,
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

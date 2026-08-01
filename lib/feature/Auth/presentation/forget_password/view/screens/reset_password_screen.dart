import 'package:exam_app/config/helpers/validator/app_validators.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/constant/app_string.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_textfeild.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/header_section.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  late final ForgetPasswordViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ForgetPasswordViewModel>();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
      listener: (context, state) {
        if (state.resetPasswordState.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppString.passwordResetSuccessfully),
              backgroundColor: Colors.green,
            ),
          );
          context.goNamed(AppRoutesNamed.login);
        } else if (state.resetPasswordState.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.resetPasswordState.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: colors.white,
        appBar: CustomAppBar(title: AppString.password),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                const HeaderSection(
                  title: AppString.resetPasswordTitle,
                  subtitle: AppString.resetPasswordSubtitle,
                ),
                SizedBox(height: 32.h),
                CustomTextField(
                  label: AppString.newPassword,
                  hint: AppString.enterYourPassword,
                  controller: passwordController,
                  obscureText: true,
                  validator: AppValidators.resetPasswordValidator,
                ),
                SizedBox(height: 24.h),
                CustomTextField(
                  label: AppString.confirmPassword,
                  hint: AppString.confirmPasswordHint,
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) => AppValidators.confirmPasswordValidator(
                    value,
                    passwordController.text,
                  ),
                ),
                SizedBox(height: 48.h),
                SizedBox(
                  width: double.infinity,
                  child:
                      BlocBuilder<
                        ForgetPasswordViewModel,
                        ForgetPasswordState 
                      >(
                        builder: (context, state) {
                          return state.resetPasswordState.isLoading
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: colors.blue,
                                  ),
                                )
                              : CustomButton(
                                  text: AppString.continueText,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      viewModel.doEvent(
                                        ResetPassword(passwordController.text),
                                      );
                                    }
                                  },
                                );
                        },
                      ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

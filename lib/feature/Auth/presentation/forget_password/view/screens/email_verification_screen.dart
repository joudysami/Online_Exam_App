import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/constant/app_string.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/header_section.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/pin_code_input.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/resend_code_text.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      EmailVerificationScreenState();
}

class EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final PinInputController pinController = PinInputController();

  late final ForgetPasswordViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<ForgetPasswordViewModel>();
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  void onResendPressed(BuildContext context) {
    context.read<ForgetPasswordViewModel>().doEvent(ClearVerifyCodeError());
    pinController.clear();
    pinController.clearError();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocListener<ForgetPasswordViewModel, ForgetPasswordState>(
      listener: (context, state) {
        if (state.verifyCodeState.data != null) {
          context.pushNamed(AppRoutesNamed.resetPassword);
        } else if (state.verifyCodeState.errorMessage.isNotEmpty) {
          pinController.triggerError();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.verifyCodeState.errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(title: AppString.password),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24.h),
              const HeaderSection(
                title: AppString.emailVerificationTitle,
                subtitle: AppString.emailVerificationSubtitle,
              ),
              SizedBox(height: 32.h),
              BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                buildWhen: (previous, current) {
                  return previous.verifyCodeState != current.verifyCodeState;
                },
                builder: (context, state) {
                  return state.verifyCodeState.isLoading
                      ? Padding(
                          padding: EdgeInsets.only(top: 20.h),
                          child: CircularProgressIndicator(color: colors.blue),
                        )
                      : PinCodeInput(
                          pinController: pinController,
                          hasError:
                              state.verifyCodeState.errorMessage.isNotEmpty,
                          onChanged: (value) {
                            if (state.verifyCodeState.errorMessage.isNotEmpty) {
                              context.read<ForgetPasswordViewModel>().doEvent(
                                ClearVerifyCodeError(),
                              );
                              pinController.clearError();
                            }
                          },
                          onCompleted: (code) {
                            viewModel.doEvent(EmailVerification(code));
                          },
                        );
                },
              ),
              BlocBuilder<ForgetPasswordViewModel, ForgetPasswordState>(
                buildWhen: (previous, current) {
                  return previous.verifyCodeState != current.verifyCodeState;
                },
                builder: (context, state) {
                  if (state.verifyCodeState.errorMessage.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: colors.error,
                          size: 16.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          AppString.invalidCode,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colors.error,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 35.h),
              ResendCodeText(onResendPressed: () => onResendPressed(context)),
            ],
          ),
        ),
      ),
    );
  }
}

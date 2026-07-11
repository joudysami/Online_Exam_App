import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/screens/reset_password_screen.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/header_section.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/pin_code_input.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/resend_code_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final PinInputController pinController = PinInputController();
  bool hasError = false;

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  void onCodeCompleted(String code) {
    if (code == '1234') {
      setState(() {
        hasError = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
      );
    } else {
      setState(() {
        hasError = true;
      });
      pinController.triggerError();
    }
  }

  void onResendPressed() {
    setState(() {
      hasError = false;
    });
    pinController.clear();
    pinController.clearError();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Password',),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             SizedBox(height: 24.h),
            const HeaderSection(
              title: 'Email verification',
              subtitle:
                  'Please enter your code that send to your\nemail address',
            ),
             SizedBox(height: 32.h),
            PinCodeInput(
              pinController: pinController,
              hasError: hasError,
              onChanged: (value) {
                if (hasError) {
                  setState(() {
                    hasError = false;
                  });
                  pinController.clearError();
                }
              },
              onCompleted: onCodeCompleted,
            ),
            if (hasError) ...[
               SizedBox(height: 8.h),
               Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.error_outline, color: colors.error, size: 16.sp),
                  SizedBox(width:4.w),
                  Text(
                    'Invalid code',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: colors.error,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
             SizedBox(height: 35.h),
            ResendCodeText(onResendPressed:(){context.pushNamed(AppRoutesNamed.resetPassword);
            }),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:exam_app/forget_password/screens/reset_password_screen.dart';
import 'package:exam_app/forget_password/widgets/custom_app_bar.dart';
import 'package:exam_app/forget_password/widgets/header_section.dart';
import 'package:exam_app/forget_password/widgets/pin_code_input.dart';
import 'package:exam_app/forget_password/widgets/resend_code_text.dart';

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const HeaderSection(
              title: 'Email verification',
              subtitle:
                  'Please enter your code that send to your\nemail address',
            ),
            const SizedBox(height: 32),
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
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Invalid code',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 16),
            ResendCodeText(onResendPressed: onResendPressed),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:exam_app/forget_password/widgets/custom_app_bar.dart';
import 'package:exam_app/forget_password/widgets/custom_button.dart';
import 'package:exam_app/forget_password/widgets/custom_text_form_field.dart';
import 'package:exam_app/forget_password/widgets/header_section.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? passwordError;
  String? confirmPasswordError;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  bool isValidPassword(String password) {
    return password.length >= 6 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password);
  }

  void onContinuePressed() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    bool hasError = false;

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Password is required';
      });
      hasError = true;
    } else if (!isValidPassword(password)) {
      setState(() {
        passwordError =
            'Password must contain at least 6 characters with upper case letter and one number';
      });
      hasError = true;
    } else {
      setState(() {
        passwordError = null;
      });
    }

    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordError = 'Please confirm your password';
      });
      hasError = true;
    } else if (confirmPassword != password) {
      setState(() {
        confirmPasswordError = 'Passwords do not match';
      });
      hasError = true;
    } else {
      setState(() {
        confirmPasswordError = null;
      });
    }

    if (!hasError) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            const HeaderSection(
              title: 'Reset password',
              subtitle:
                  'Password must not be empty and must contain\n6 characters with upper case letter and one\nnumber at least',
            ),
            const SizedBox(height: 32),
            CustomTextFormField(
              label: 'New password',
              hintText: 'Enter you password',
              obscureText: true,
              controller: passwordController,
              errorText: passwordError,
              onChanged: (_) {
                if (passwordError != null) {
                  setState(() {
                    passwordError = null;
                  });
                }
              },
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              label: 'Confirm password',
              hintText: 'Confirm password',
              obscureText: true,
              controller: confirmPasswordController,
              errorText: confirmPasswordError,
              onChanged: (_) {
                if (confirmPasswordError != null) {
                  setState(() {
                    confirmPasswordError = null;
                  });
                }
              },
            ),
            const SizedBox(height: 48),
            CustomButton(
              text: 'Continue',
              onPressed: onContinuePressed,
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

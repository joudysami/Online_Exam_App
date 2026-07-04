import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:exam_app/core/constant/app_colors.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/screens/email_verification_screen.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/custom_button.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/custom_text_form_field.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/header_section.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? emailError;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void onContinuePressed() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
      return;
    }

    if (!isValidEmail(email)) {
      setState(() {
        emailError = 'This Email is not valid';
      });
      return;
    }

    setState(() {
      emailError = null;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmailVerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              const HeaderSection(
                title: 'Forget password',

                subtitle: 'Please enter your email associated to\nyour account',
              ),
              SizedBox(height: 32.h),
              CustomTextFormField(
                label: 'Email',
                hintText: 'Enter you email',
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                errorText: emailError,
                onChanged: (_) {
                  if (emailError != null) {
                    setState(() {
                      emailError = null;
                    });
                  }
                },
              ),
              SizedBox(height: 48.h),
              CustomButton(text: 'Continue', onPressed: onContinuePressed),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

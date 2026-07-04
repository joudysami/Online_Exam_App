import 'package:flutter/material.dart';
import 'package:exam_app/forget_password/screens/email_verification_screen.dart';
import 'package:exam_app/forget_password/widgets/custom_app_bar.dart';
import 'package:exam_app/forget_password/widgets/custom_button.dart';
import 'package:exam_app/forget_password/widgets/custom_text_form_field.dart';
import 'package:exam_app/forget_password/widgets/header_section.dart';

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
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const HeaderSection(
                title: 'Forget password',

                subtitle: 'Please enter your email associated to\nyour account',
              ),
              const SizedBox(height: 32),
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
              const SizedBox(height: 48),
              CustomButton(text: 'Continue', onPressed: onContinuePressed),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

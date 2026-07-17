import 'package:exam_app/config/Di/di.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/config/helpers/validator/app_validators.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_textfeild.dart';
import 'package:exam_app/feature/Auth/domain/entity/auth_entity.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view/widgets/header_section.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:exam_app/feature/Auth/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late final TextEditingController emailController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   late final ForgetPasswordViewModel viewModel = getIt<ForgetPasswordViewModel>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return BlocConsumer<ForgetPasswordViewModel, BaseState<AuthEntity>>(
      bloc: viewModel,
      listener: (context, state) {
          if (state.data != null) {
          context.pushNamed(AppRoutesNamed.emailVerification);
        } else if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
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
                  SizedBox(height: 40.h),
                  HeaderSection(
                    title: 'Forget password',
                    subtitle: 'Please enter your email associated to\nyour account',
                  ),
                  SizedBox(height: 32.h),
                  CustomTextField(
                    label: 'Email',
                    hint: 'Enter your email',
                    validator: AppValidators.emailValidator,
                    controller: emailController,
                  ),
                  SizedBox(height: 48.h),
                  SizedBox(
                    width: double.infinity,
                    child: state.isLoading
                        ? Center(child: CircularProgressIndicator(color: colors.blue))
                        : CustomButton(
                            text: 'Continue',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                viewModel.doEvent(ForgetPassword(
                                  emailController.text.trim(),
                                ));
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


import 'package:exam_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:exam_app/config/Di/di.dart';
import 'package:exam_app/core/widgets/custom_textfeild.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/feature/Profile/presentation/view_model/profile_view_model.dart';
import 'package:exam_app/feature/Profile/presentation/view_model/profile_event.dart';
import 'package:exam_app/feature/Profile/data/models/edit_profile_request.dart';
import 'package:exam_app/core/constant/app_strings.dart';
import 'package:exam_app/core/utils/validators.dart';

import '../../../../../config/routes/app_routes_named.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileViewModel>(),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<ProfileViewModel>().doEvent(GetProfileDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocListener<ProfileViewModel, ProfileState>(
      listener: (context, state) {
        if (state.profileState.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.profileState.errorMessage, style: TextStyle(color: colors.white)), backgroundColor: colors.error),
          );
        } else if (!state.profileState.isLoading && state.profileState.errorMessage.isEmpty && state.profileState.data != null && !state.isEditing) {
          // You might want to show success message if updated
        }

        if (state.profileState.data != null && !state.isEditing) {
           _usernameController.text = state.profileState.data!.username;
           _firstNameController.text = state.profileState.data!.firstName;
           _lastNameController.text = state.profileState.data!.lastName;
           _emailController.text = state.profileState.data!.email;
           _phoneController.text = state.profileState.data!.phone;
        }
      },
      child: BlocBuilder<ProfileViewModel, ProfileState>(
        builder: (context, state) {

          return Scaffold(
            backgroundColor: colors.white,
            appBar: state.isEditing 
                ? const CustomAppBar(title: AppStrings.edit)
                : AppBar(
                    backgroundColor: colors.white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: Text(
                      AppStrings.profile,
                      style: TextStyle(
                        color: colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 40.r,
                      backgroundColor: colors.unselectedAnswer,
                      child: Icon(Icons.person, size: 50.r, color: colors.grey),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  
                  CustomTextField(
                    hint: AppStrings.userName,
                    label: AppStrings.userName,
                    controller: _usernameController,
                    readOnly: !state.isEditing,
                    validator: (val) => Validators.validateRequired(val, AppStrings.userName),
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hint: AppStrings.firstName,
                          label: AppStrings.firstName,
                          controller: _firstNameController,
                          readOnly: !state.isEditing,
                          validator: (val) => Validators.validateRequired(val, AppStrings.firstName),
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          hint: AppStrings.lastName,
                          label: AppStrings.lastName,
                          controller: _lastNameController,
                          readOnly: !state.isEditing,
                          validator: (val) => Validators.validateRequired(val, AppStrings.lastName),
                        ),
                      ),
                    ],
                  ),

                  CustomTextField(
                    hint: AppStrings.email,
                    label: AppStrings.email,
                    controller: _emailController,
                    readOnly: !state.isEditing,
                    validator: Validators.validateEmail,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        TextFormField(
                          initialValue: '******',
                          readOnly: true,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: AppStrings.newPassword,
                          ),
                        ),
                        Positioned(
                          right: 10.w,
                          child: TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutesNamed.changePassword);
                            },
                            child: Text(
                              AppStrings.edit,
                              style: TextStyle(
                                color: colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  CustomTextField(
                    hint: AppStrings.phoneNumber,
                    label: AppStrings.phoneNumber,
                    controller: _phoneController,
                    readOnly: !state.isEditing,
                    validator: (val) => Validators.validateRequired(val, AppStrings.phoneNumber),
                  ),

                  SizedBox(height: 30.h),
                  
                  if (state.profileState.isLoading)
                    Center(child: CircularProgressIndicator(color: colors.blue))
                  else
                    CustomButton(
                      text: state.isEditing ? AppStrings.save : AppStrings.edit,
                      onTap: state.isEditing ? () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProfileViewModel>().doEvent(
                            UpdateProfileEvent(
                              EditProfileRequest(
                                username: _usernameController.text,
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                              )
                            )
                          );
                        }
                      } : () {
                        context.read<ProfileViewModel>().doEvent(ToggleEditModeEvent(true));
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

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}

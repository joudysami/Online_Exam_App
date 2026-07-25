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
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocConsumer<ProfileViewModel, ProfileState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage, style: TextStyle(color: colors.white)), backgroundColor: colors.error),
          );
        }
      },
      builder: (context, state) {
        if (state.data != null && !state.isEditing) {
           _usernameController.text = state.data!.username;
           _firstNameController.text = state.data!.firstName;
           _lastNameController.text = state.data!.lastName;
           _emailController.text = state.data!.email;
           _phoneController.text = state.data!.phone;
        }

        return Scaffold(
          backgroundColor: colors.white,
          appBar: state.isEditing 
              ? const CustomAppBar(title: 'Edit profile')
              : AppBar(
                  backgroundColor: colors.white,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: Text(
                    'Profile',
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
                    child: GestureDetector(
                      onTap: state.isEditing ? () async {
                        final picker = ImagePicker();
                        final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          context.read<ProfileViewModel>().doEvent(SelectProfileImageEvent(File(image.path)));
                        }
                      } : null,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundColor: colors.unselectedAnswer,
                            backgroundImage: state.selectedImage != null ? FileImage(state.selectedImage!) : null,
                            child: state.selectedImage == null ? Icon(Icons.person, size: 50.r, color: colors.grey) : null,
                          ),
                          if (state.isEditing)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  color: colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.camera_alt, color: colors.white, size: 16.r),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25.h),
                  
                  CustomTextField(
                    hint: 'User name',
                    label: 'User name',
                    controller: _usernameController,
                  ),
                  
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hint: 'First name',
                          label: 'First name',
                          controller: _firstNameController,
                        ),
                      ),
                      Expanded(
                        child: CustomTextField(
                          hint: 'Last name',
                          label: 'Last name',
                          controller: _lastNameController,
                        ),
                      ),
                    ],
                  ),

                  CustomTextField(
                    hint: 'Email',
                    label: 'Email',
                    controller: _emailController,
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
                            labelText: 'Password',
                          ),
                        ),
                        Positioned(
                          right: 10.w,
                          child: TextButton(
                            onPressed: () {
                              context.pushNamed(AppRoutesNamed.changePassword);
                            },
                            child: Text(
                              'Change',
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
                    hint: 'Phone number',
                    label: 'Phone number',
                    controller: _phoneController,
                  ),

                  SizedBox(height: 30.h),
                  
                  if (state.isLoading)
                    Center(child: CircularProgressIndicator(color: colors.blue))
                  else
                    CustomButton(
                      text: 'Update',
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
                                imageFile: state.selectedImage,
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
          ),
        );
      },
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

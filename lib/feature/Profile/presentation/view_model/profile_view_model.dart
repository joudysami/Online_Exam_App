import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'dart:io';
import 'package:exam_app/feature/Profile/domain/entity/profile_entity.dart';
import 'package:exam_app/feature/Profile/domain/usecase/edit_profile_usecase.dart';
import 'package:exam_app/feature/Profile/domain/usecase/change_password_usecase.dart';
import 'package:exam_app/feature/Profile/data/models/edit_profile_request.dart';
import 'package:exam_app/feature/Profile/data/models/change_password_request.dart';
import 'package:exam_app/feature/Profile/presentation/view_model/profile_event.dart';

class ProfileState extends BaseState<ProfileEntity> {
  final bool isEditing;
  final File? selectedImage;
  
  ProfileState({
    super.isLoading,
    super.errorMessage,
    super.data,
    this.isEditing = false,
    this.selectedImage,
  });

  @override
  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    ProfileEntity? data,
    bool? isEditing,
    File? selectedImage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
      isEditing: isEditing ?? this.isEditing,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final EditProfileUseCase editProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileViewModel(this.editProfileUseCase, this.changePasswordUseCase) 
      : super(ProfileState());

  void doEvent(ProfileEvent event) {
    switch (event) {
      case ToggleEditModeEvent():
        _toggleEditMode(event.isEditing);
        break;
      case SelectProfileImageEvent():
        _selectProfileImage(event.image);
        break;
      case UpdateProfileEvent():
        _updateProfile(event.request);
        break;
      case ChangePasswordEvent():
        _changePassword(event.request);
        break;
    }
  }

  void _toggleEditMode(bool isEditing) {
    emit(state.copyWith(isEditing: isEditing));
  }

  void _selectProfileImage(File image) {
    emit(state.copyWith(selectedImage: image));
  }

  Future<void> _updateProfile(EditProfileRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final response = await editProfileUseCase(request);
    
    if (response is SuccessResponse<ProfileEntity>) {
      emit(
        state.copyWith(
          isLoading: false,
          data: response.data,
          errorMessage: '',
          isEditing: false,
        ),
      );
    } else if (response is ErrorResponse) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: (response as ErrorResponse).errorMessage,
        ),
      );
    }
  }

  Future<void> _changePassword(ChangePasswordRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final response = await changePasswordUseCase(request);
    
    if (response is SuccessResponse<String>) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: '',
        ),
      );
    } else if (response is ErrorResponse) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: (response as ErrorResponse).errorMessage,
        ),
      );
    }
  }
}

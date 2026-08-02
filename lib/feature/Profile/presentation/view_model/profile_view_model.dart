import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/feature/Profile/domain/entity/profile_entity.dart';
import 'package:exam_app/feature/Profile/domain/usecase/edit_profile_usecase.dart';
import 'package:exam_app/feature/Profile/domain/usecase/change_password_usecase.dart';
import 'package:exam_app/feature/Profile/data/models/edit_profile_request.dart';
import 'package:exam_app/feature/Profile/data/models/change_password_request.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_app/feature/Profile/domain/usecase/get_profile_data_usecase.dart';
import 'package:exam_app/feature/Profile/presentation/view_model/profile_event.dart';

class ProfileState extends Equatable {
  final BaseState<ProfileEntity> profileState;
  final bool isEditing;
  
  const ProfileState({
    required this.profileState,
    this.isEditing = false,
  });

  ProfileState copyWith({
    BaseState<ProfileEntity>? profileState,
    bool? isEditing,
  }) {
    return ProfileState(
      profileState: profileState ?? this.profileState,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [profileState, isEditing];
}

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final GetProfileDataUseCase getProfileDataUseCase;
  final EditProfileUseCase editProfileUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  ProfileViewModel(this.getProfileDataUseCase, this.editProfileUseCase, this.changePasswordUseCase) 
      : super(ProfileState(profileState: BaseState()));

  void doEvent(ProfileEvent event) {
    switch (event) {
      case GetProfileDataEvent():
        _getProfileData();
        break;
      case ToggleEditModeEvent():
        _toggleEditMode(event.isEditing);
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

  Future<void> _getProfileData() async {
    emit(state.copyWith(profileState: state.profileState.copyWith(isLoading: true, errorMessage: '')));

    final response = await getProfileDataUseCase();
    switch (response) {
      case SuccessResponse<ProfileEntity>():
        emit(
          state.copyWith(
            profileState: state.profileState.copyWith(
              isLoading: false,
              data: response.data,
              errorMessage: '',
            ),
          ),
        );
      case ErrorResponse<ProfileEntity>():
        emit(
          state.copyWith(
            profileState: state.profileState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _updateProfile(EditProfileRequest request) async {
    emit(state.copyWith(profileState: state.profileState.copyWith(isLoading: true, errorMessage: '')));

    final response = await editProfileUseCase(request);
    
    switch (response) {
      case SuccessResponse<ProfileEntity>():
        emit(
          state.copyWith(
            profileState: state.profileState.copyWith(
              isLoading: false,
              data: response.data,
              errorMessage: '',
            ),
            isEditing: false,
          ),
        );
      case ErrorResponse<ProfileEntity>():
        emit(
          state.copyWith(
            profileState: state.profileState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
    }
  }

  Future<void> _changePassword(ChangePasswordRequest request) async {
    emit(state.copyWith(profileState: state.profileState.copyWith(isLoading: true, errorMessage: '')));

    final response = await changePasswordUseCase(request);
    
    switch (response) {
      case SuccessResponse<String>():
        emit(
          state.copyWith(
            profileState: state.profileState.copyWith(
              isLoading: false,
              errorMessage: '',
            ),
          ),
        );
      case ErrorResponse<String>():
        emit(
          state.copyWith(
            profileState: state.profileState.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
    }
  }
}

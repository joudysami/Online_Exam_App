import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/usecase/subject_use_case.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view_model/subject_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectViewModel extends Cubit<BaseState<List<SubjectEntity>>> {
  final GetSubjectsUseCase subjectUseCase;
  SubjectViewModel(this.subjectUseCase)
    : super(BaseState<List<SubjectEntity>>());

  List<SubjectEntity> allSubjects = [];
  
 Future<void> doEvent(SubjectEvent event) async {
  switch (event) {
    case GetAllSubject():
      await _getAllSubject();
      break;
  }
}

  Future<void> _getAllSubject() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final response = await subjectUseCase();
    switch (response) {
      case SuccessResponse<List<SubjectEntity>>():
        allSubjects = response.data;
        emit(
          state.copyWith(isLoading: false, data: allSubjects, errorMessage: ''),
        );
      case ErrorResponse<List<SubjectEntity>>():
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: (response as ErrorResponse).errorMessage,
          ),
        );
    }
  }

  void searchSubjects(String query) {
    if (query.trim().isEmpty) {
      emit(state.copyWith(data: allSubjects));
      return;
    }

    final filteredSubjects = allSubjects.where((subject) {
      return subject.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(state.copyWith(data: filteredSubjects));
  }
}

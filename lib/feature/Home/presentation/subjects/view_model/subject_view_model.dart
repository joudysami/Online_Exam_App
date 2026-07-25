import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/usecase/exams_usecase.dart';
import 'package:exam_app/feature/Home/domain/usecase/subject_usecase.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view_model/subject_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectViewModel extends Cubit<BaseState<List<SubjectEntity>>> {
  final SubjectUseCase subjectUseCase;
  final GetExamsUseCase examsUseCase;
  SubjectViewModel(this.subjectUseCase, this.examsUseCase)
      : super(BaseState<List<SubjectEntity>>());

void doEvent(SubjectEvent event){
    switch(event) {
      case GetAllSubject():
      _getAllSubject();
      
        break;
       
    }
  }

  Future<void> _getAllSubject() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final response = await subjectUseCase();
   
     if (response is SuccessResponse) {
      emit(
        state.copyWith(
          isLoading: false,
          data: (response as SuccessResponse).data,
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

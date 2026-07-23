import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/usecase/subject_usecase.dart';
import 'package:exam_app/feature/Home/presentation/view_model/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<BaseState<List<SubjectEntity>>> {
  final SubjectUseCase subjectUseCase;
  HomeViewModel(this.subjectUseCase) : super(BaseState<List<SubjectEntity>>());

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
   
    if (response is SuccessResponse<List<SubjectEntity>>) {
      final success = response as SuccessResponse<List<SubjectEntity>>;
      print(success.data.first.icon);
      emit(
        state.copyWith(
          isLoading: false,
          data: success.data,
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

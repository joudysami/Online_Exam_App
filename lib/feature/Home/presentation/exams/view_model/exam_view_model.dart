import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Home/data/models/exams_response.dart';
import 'package:exam_app/feature/Home/domain/entity/exam_entity.dart';
import 'package:exam_app/feature/Home/domain/usecase/exams_usecase.dart';
import 'package:exam_app/feature/Home/presentation/exams/view_model/exam_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ExamsViewModel extends Cubit<BaseState<List<ExamEntity>>> {
  final GetExamsUseCase getExamsUseCase;

  ExamsViewModel(this.getExamsUseCase)
      : super(BaseState<List<ExamEntity>>());

void doEvent(ExamEvent event){
    switch(event) {
      case GetAllExams():
      _getAllExams(event.subjectId);
      
        break;
       
    }
  }
  Future<void> _getAllExams(String subjectId) async {
    emit(state.copyWith(isLoading: true));
    final response = await getExamsUseCase(subjectId);
    if (response is SuccessResponse<ExamsResponse>) {
      emit(
        state.copyWith(
          isLoading: false,
          data: response.data.exams
                  ?.map((e) => e.toDomain())
                  .toList() ??
              [],
        ),
      );
    } else if (response is ErrorResponse<ExamsResponse>) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: response.errorMessage,
        ),
      );
    }
  }
}
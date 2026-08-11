import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/errors/app_error.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/usecase/subject_use_case.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view_model/subject_event.dart';
import 'package:exam_app/feature/Home/presentation/subjects/view_model/subject_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'subject_view_model_test.mocks.dart';

//getSubject success
//getSubject failure

@GenerateMocks([GetSubjectsUseCase])
void main() {
  late GetSubjectsUseCase getSubjectsUseCase;
  late SubjectViewModel subjectViewModel;
  final subjects = [SubjectEntity(id: '1', name: 'Math', icon: 'math')];
  setUp(() {
    getSubjectsUseCase = MockGetSubjectsUseCase();
    subjectViewModel = SubjectViewModel(getSubjectsUseCase);
  });
  String dummyErrorMessage = "Dummy Message";
  group("this test for load data event", () {
    test("success data", () async {
      //arrange

      provideDummy<BaseResponse<List<SubjectEntity>>>(
        SuccessResponse(subjects),
      );

      when(
        getSubjectsUseCase.call(),
      ).thenAnswer((_) async => SuccessResponse(subjects));
      //act
      await subjectViewModel.doEvent(GetAllSubject());
      //expect
      expect(subjectViewModel.state.isLoading, false);
      expect(subjectViewModel.state.data, (subjects));
    });
  });
  test('Success with empty list', () async {
    //AAA
    //Arrange

    provideDummy<BaseResponse<List<SubjectEntity>>>(SuccessResponse(subjects));
    when(
      getSubjectsUseCase.call(),
    ).thenAnswer((_) async => SuccessResponse([]));

    //Act
    await subjectViewModel.doEvent(GetAllSubject());
    subjectViewModel.allSubjects == [];
    //Assert

    expect(subjectViewModel.allSubjects, isEmpty);
    expect(subjectViewModel.allSubjects.length, isZero);
  });
  test('Error with error message', () async {
    //AAA
    //Arrange
    final error = BadResponseError(dummyErrorMessage);

    provideDummy<BaseResponse<List<SubjectEntity>>>(
      ErrorResponse<List<SubjectEntity>>(appError: error),
    );

    when(getSubjectsUseCase.call()).thenAnswer(
      (_) async => ErrorResponse<List<SubjectEntity>>(appError: error),
    );

    //Act
    await subjectViewModel.doEvent(GetAllSubject());
    //Assert
    expect(subjectViewModel.state.isLoading, false);
    expect(subjectViewModel.allSubjects, isEmpty);
    expect(subjectViewModel.state.errorMessage, isNotNull);
    expect(subjectViewModel.state.errorMessage, dummyErrorMessage);
  });
}

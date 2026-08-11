import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/errors/app_error.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:exam_app/feature/Home/domain/repo/home_repo.dart';
import 'package:exam_app/feature/Home/domain/usecase/subject_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'subject_use_case_test.mocks.dart';

@GenerateMocks([HomeRepo])
void main() {
  late HomeRepo homeRepo;
  late GetSubjectsUseCase getSubjectsUseCase;
  String dummyErrorMessage = "Dummy Message";

  setUpAll(() {
    homeRepo = MockHomeRepo();
    getSubjectsUseCase = GetSubjectsUseCase(homeRepo);
  });
  group("test use case states", () {
    test("test get banners use case success state", () async {
      provideDummy<BaseResponse<List<SubjectEntity>>>(SuccessResponse([]));
      when(
        homeRepo.getAllSubjects(),
      ).thenAnswer((_) async => SuccessResponse([]));

      var response = await getSubjectsUseCase.call();
      expect(response, isA<BaseResponse<List<SubjectEntity>>>());
    });
  });
  test("test get banners use case error state", ()async{
     final error = BadResponseError(dummyErrorMessage);
     provideDummy<BaseResponse<List<SubjectEntity>>>(ErrorResponse(appError:error ));
      when(
        homeRepo.getAllSubjects(),
      ).thenAnswer((_) async => ErrorResponse(appError: error));

      var response = await getSubjectsUseCase.call();
      expect(response, isA<BaseResponse<List<SubjectEntity>>>());
    });
}


import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/config/network/safe_call.dart';
import 'package:exam_app/feature/Home/data/data_source/remote/home_remote_datasource.dart';
import 'package:exam_app/feature/Home/data/models/subjects_response.dart';
import 'package:exam_app/feature/Home/data/repo/home_repo_impl.dart';
import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_repo_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDatasource, SafeCall])
void main() {
  late HomeRepoImpl homeRepoImpl;
  late MockHomeRemoteDatasource mockHomeRemoteDatasource;
  late SafeCall safeCall;

  setUpAll(() {
    print("////SetUpAll///");
    // Arrange
    provideDummy<BaseResponse<List<SubjectEntity>>>(
      SuccessResponse<List<SubjectEntity>>([]),
    );
    mockHomeRemoteDatasource = MockHomeRemoteDatasource();
    safeCall = SafeCall();
    homeRepoImpl = HomeRepoImpl(mockHomeRemoteDatasource, safeCall);
  });

  group("Get All Subject , function tests", () {
    test("Success subject with non_empty 5 sub", () async {
      // Arrange
      final dummySubjects = [
        Subject(id: "1", name: "Subject 1", icon: "icon1"),
        Subject(id: "2", name: "Subject 2", icon: "icon2"),
        Subject(id: "3", name: "Subject 3", icon: "icon3"),
        Subject(id: "4", name: "Subject 4", icon: "icon4"),
        Subject(id: "5", name: "Subject 5", icon: "icon5"),
      ];
      when(mockHomeRemoteDatasource.geAllSubjects()).thenAnswer(
        (_) async => SubjectsResponse(subjects: dummySubjects),
      );
      // Act
      final result = await homeRepoImpl.getAllSubjects();
      // Assert
      expect(result, isA<SuccessResponse<List<SubjectEntity>>>());
      final successResult = result as SuccessResponse<List<SubjectEntity>>;
      expect(successResult.data.length, 5);
      expect(successResult.data[0].id, "1");
      expect(successResult.data[0].name, "Subject 1");
      expect(successResult.data[0].icon, "icon1");
    });

    test("Success subject with empty sub", () async {
      // Arrange
      when(mockHomeRemoteDatasource.geAllSubjects()).thenAnswer(
        (_) async => SubjectsResponse(subjects: []),
      );
      // Act
      final result = await homeRepoImpl.getAllSubjects();
      // Assert
      expect(result, isA<SuccessResponse<List<SubjectEntity>>>());
      final successResult = result as SuccessResponse<List<SubjectEntity>>;
      expect(successResult.data, isEmpty);
    });
  });
}

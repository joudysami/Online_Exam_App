import 'package:exam_app/feature/Home/data/models/subjects_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'single_subject_response.g.dart';
@JsonSerializable()
class SingleSubjectResponse {
  final String? message;
  final Subject? category;

  SingleSubjectResponse({
    this.message,
    this.category,
  });
  factory SingleSubjectResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleSubjectResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SingleSubjectResponseToJson(this);
}
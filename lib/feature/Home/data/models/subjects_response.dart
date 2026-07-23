import 'package:exam_app/feature/Home/domain/entity/subject_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'exams_response.dart';

part 'subjects_response.g.dart';

@JsonSerializable()
class SubjectsResponse {
  final String? message;
  final Metadata? metadata;
  final List<Subject>? subjects;

  SubjectsResponse({this.message, this.metadata, this.subjects});

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$SubjectsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectsResponseToJson(this);
}

@JsonSerializable()
class Subject {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? icon;
  final String? createdAt;

  Subject({this.id, this.name, this.icon, this.createdAt});
  SubjectEntity toDomain() {
    return SubjectEntity(
      id: id ?? "",
       name: name ?? "", 
       icon: icon ?? "");
  }

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

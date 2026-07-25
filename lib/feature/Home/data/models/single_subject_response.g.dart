// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_subject_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleSubjectResponse _$SingleSubjectResponseFromJson(
  Map<String, dynamic> json,
) => SingleSubjectResponse(
  message: json['message'] as String?,
  category: json['category'] == null
      ? null
      : Subject.fromJson(json['category'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SingleSubjectResponseToJson(
  SingleSubjectResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'category': instance.category,
};

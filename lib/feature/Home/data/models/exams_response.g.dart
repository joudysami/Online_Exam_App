// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exams_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExamsResponse _$ExamsResponseFromJson(Map<String, dynamic> json) =>
    ExamsResponse(
      message: json['message'] as String?,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      exams: (json['exams'] as List<dynamic>?)
          ?.map((e) => Exam.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExamsResponseToJson(ExamsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'exams': instance.exams,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  currentPage: (json['currentPage'] as num?)?.toInt(),
  numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'numberOfPages': instance.numberOfPages,
  'limit': instance.limit,
};

Exam _$ExamFromJson(Map<String, dynamic> json) => Exam(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  duration: (json['duration'] as num?)?.toInt(),
  subject: json['subject'] as String?,
  numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
  active: json['active'] as bool?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$ExamToJson(Exam instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'duration': instance.duration,
  'subject': instance.subject,
  'numberOfQuestions': instance.numberOfQuestions,
  'active': instance.active,
  'createdAt': instance.createdAt,
};

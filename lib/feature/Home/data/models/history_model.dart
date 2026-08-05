import 'package:exam_app/feature/Home/data/models/questions_response.dart';
import 'package:exam_app/feature/Home/domain/entity/history_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  @JsonKey(name: '_id')
  final String? id;

  final String? checkAnswer;

  @JsonKey(name: 'QID')
  final QuestionModel? question;

  final String? user;
  final String? chosenAnswer;
  final String? avgAnswerTime;
  final String? createdAt;

  HistoryModel({
    this.id,
    this.checkAnswer,
    this.question,
    this.user,
    this.chosenAnswer,
    this.avgAnswerTime,
    this.createdAt,
  });
  HistoryEntity toDomain() {
  return HistoryEntity(
    id: id ?? '',
    question: question?.question ?? '',
    answers: question?.answers?.map((e) => e.toDomain()).toList() ?? [],
    correctAnswer: question?.correct ?? '',
    chosenAnswer: chosenAnswer ?? '',
    checkAnswer: checkAnswer ?? '',
    avgAnswerTime: avgAnswerTime ?? '',
  );
}

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}

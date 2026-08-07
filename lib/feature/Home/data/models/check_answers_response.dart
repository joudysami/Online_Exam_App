import 'package:exam_app/feature/Home/domain/entity/score_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_answers_response.g.dart';

@JsonSerializable()
class CheckAnswersResponse {
  final String? message;
  final int? correct;
  final int? wrong;
  final String? total;

  CheckAnswersResponse({this.message, this.correct, this.wrong, this.total});

  ScoreEntity toDomain() {
    final totalQuestions = (correct ?? 0) + (wrong ?? 0);
    return ScoreEntity(
      correct: correct ?? 0,
      incorrect: wrong ?? 0,
      total: totalQuestions,
    );
  }

  factory CheckAnswersResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckAnswersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAnswersResponseToJson(this);
}

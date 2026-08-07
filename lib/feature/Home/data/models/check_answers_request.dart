import 'package:json_annotation/json_annotation.dart';

part 'check_answers_request.g.dart';

@JsonSerializable()
class CheckAnswersRequest {
  final List<AnswerItemRequest> answers;
  final int? time;

  CheckAnswersRequest({required this.answers, this.time});

  factory CheckAnswersRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckAnswersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAnswersRequestToJson(this);
}

@JsonSerializable()
class AnswerItemRequest {
  final String questionId;
  final String correct;

  AnswerItemRequest({required this.questionId, required this.correct});

  factory AnswerItemRequest.fromJson(Map<String, dynamic> json) =>
      _$AnswerItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerItemRequestToJson(this);
}

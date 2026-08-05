import 'package:exam_app/feature/Home/data/models/history_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'history_response.g.dart';

@JsonSerializable()
class HistoryResponse {
  final String? message;
  final List<HistoryModel>? history;

  HistoryResponse({this.message, this.history});

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);
}

import 'package:equatable/equatable.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object?> get props => [];
}

class GetQuestionsEvent extends QuestionsEvent {
  final String examId;
  final String duration;
  const GetQuestionsEvent(this.examId, this.duration);

  @override
  List<Object?> get props => [examId, duration];
}

class SelectAnswerEvent extends QuestionsEvent {
  final String questionId;
  final String answerId;
  const SelectAnswerEvent({required this.questionId, required this.answerId});

  @override
  List<Object?> get props => [questionId, answerId];
}

class NextQuestionEvent extends QuestionsEvent {}

class PreviousQuestionEvent extends QuestionsEvent {}

class TimeTickEvent extends QuestionsEvent {}

class FinishExamEvent extends QuestionsEvent {
  final String examId;
  const FinishExamEvent(this.examId);

  @override
  List<Object?> get props => [examId];
}

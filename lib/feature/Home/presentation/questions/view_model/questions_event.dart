sealed class QuestionsEvent {}

class GetQuestionsEvent extends QuestionsEvent {
  final String examId;
  final String duration;
  GetQuestionsEvent(this.examId, this.duration);
}

class SelectAnswerEvent extends QuestionsEvent {
  final String questionId;
  final String answerId;
  SelectAnswerEvent({required this.questionId, required this.answerId});
}

class NextQuestionEvent extends QuestionsEvent {}

class PreviousQuestionEvent extends QuestionsEvent {}

class TimeTickEvent extends QuestionsEvent {}

class FinishExamEvent extends QuestionsEvent {
  final String examId;
  FinishExamEvent(this.examId);
}

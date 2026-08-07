import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final String id;
  final String questionText;
  final List<AnswerEntity> answers;

  const QuestionEntity({
    required this.id,
    required this.questionText,
    required this.answers,
  });

  @override
  List<Object?> get props => [id, questionText, answers];
}

class AnswerEntity extends Equatable {
  final String answerText;
  final String key;

  const AnswerEntity({
    required this.answerText,
    required this.key,
  });

  @override
  List<Object?> get props => [answerText, key];
}

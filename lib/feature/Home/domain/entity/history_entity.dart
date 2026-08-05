import 'package:equatable/equatable.dart';
import 'package:exam_app/feature/Home/domain/entity/question_entity.dart';

class HistoryEntity extends Equatable {
  final String id;
  final String question;
  final List<AnswerEntity> answers;
  final String correctAnswer;
  final String chosenAnswer;
  final String checkAnswer;
  final String avgAnswerTime;

  const HistoryEntity({
    required this.id,
    required this.question,
    required this.answers,
    required this.correctAnswer,
    required this.chosenAnswer,
    required this.checkAnswer,
    required this.avgAnswerTime,
  });

  @override
    List<Object?> get props => [
    id,
    question,
    answers,
    correctAnswer,
    chosenAnswer,
    checkAnswer,
    avgAnswerTime,
  ];
}

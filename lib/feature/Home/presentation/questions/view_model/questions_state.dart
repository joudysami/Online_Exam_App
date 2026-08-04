import 'package:equatable/equatable.dart';
import 'package:exam_app/feature/Home/domain/entity/question_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/score_entity.dart';

class QuestionsState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final List<QuestionEntity> questions;
  final int currentIndex;
  final Map<String, String> userAnswers;
  final int timeRemainingInSeconds;
  final bool isFinished;
  final bool isSubmitting;
  final ScoreEntity? score;

  const QuestionsState({
    this.isLoading = false,
    this.errorMessage = '',
    this.questions = const [],
    this.currentIndex = 0,
    this.userAnswers = const {},
    this.timeRemainingInSeconds = -1,
    this.isFinished = false,
    this.isSubmitting = false,
    this.score,
  });

  QuestionsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<QuestionEntity>? questions,
    int? currentIndex,
    Map<String, String>? userAnswers,
    int? timeRemainingInSeconds,
    bool? isFinished,
    bool? isSubmitting,
    ScoreEntity? score,
  }) {
    return QuestionsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      timeRemainingInSeconds: timeRemainingInSeconds ?? this.timeRemainingInSeconds,
      isFinished: isFinished ?? this.isFinished,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        questions,
        currentIndex,
        userAnswers,
        timeRemainingInSeconds,
        isFinished,
        isSubmitting,
        score,
      ];
}

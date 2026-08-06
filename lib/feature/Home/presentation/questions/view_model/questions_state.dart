import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/feature/Home/domain/entity/question_entity.dart';
import 'package:exam_app/feature/Home/domain/entity/score_entity.dart';

class QuestionsState extends BaseState<List<QuestionEntity>> {
  final int currentIndex;
  final Map<String, String> userAnswers;
  final int timeRemainingInSeconds;
  final bool isFinished;
  final bool isSubmitting;
  final ScoreEntity? score;

  const QuestionsState({
    super.isLoading = false,
    super.errorMessage = '',
    super.data,
    this.currentIndex = 0,
    this.userAnswers = const {},
    this.timeRemainingInSeconds = -1,
    this.isFinished = false,
    this.isSubmitting = false,
    this.score,
  });

  @override
  QuestionsState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<QuestionEntity>? data,
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
      data: data ?? this.data,
      currentIndex: currentIndex ?? this.currentIndex,
      userAnswers: userAnswers ?? this.userAnswers,
      timeRemainingInSeconds: timeRemainingInSeconds ?? this.timeRemainingInSeconds,
      isFinished: isFinished ?? this.isFinished,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      score: score ?? this.score,
    );
  }
}

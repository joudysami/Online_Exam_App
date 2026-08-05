import 'dart:async';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/feature/Home/data/models/check_answers_request.dart';
import 'package:exam_app/feature/Home/domain/usecase/check_exam_answers_usecase.dart';
import 'package:exam_app/feature/Home/domain/usecase/get_exam_questions_usecase.dart';
import 'package:exam_app/feature/Home/presentation/questions/view_model/questions_event.dart';
import 'package:exam_app/feature/Home/presentation/questions/view_model/questions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class QuestionsViewModel extends Cubit<QuestionsState> {
  final GetExamQuestionsUseCase getExamQuestionsUseCase;
  final CheckExamAnswersUseCase checkExamAnswersUseCase;
  Timer? timer;

  QuestionsViewModel(
    this.getExamQuestionsUseCase,
    this.checkExamAnswersUseCase,
  ) : super(const QuestionsState());

  void doEvent(QuestionsEvent event) {
    switch (event) {
      case GetQuestionsEvent():
        getQuestions(event.examId, event.duration);
        break;
      case SelectAnswerEvent():
        selectAnswer(event.questionId, event.answerId);
        break;
      case NextQuestionEvent():
        nextQuestion();
        break;
      case PreviousQuestionEvent():
        previousQuestion();
        break;
      case TimeTickEvent():
        onTimeTick();
        break;
      case FinishExamEvent():
        finishExam(event.examId);
        break;
    }
  }

  Future<void> getQuestions(String examId, String duration) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    
    int totalSeconds = 1800;
    try {
      final numberString = duration.replaceAll(RegExp(r'[^0-9]'), '');
      if (numberString.isNotEmpty) {
        totalSeconds = int.parse(numberString) * 60;
      }
    } catch (_) {}

    final result = await getExamQuestionsUseCase(examId);
    
    switch (result) {
      case SuccessResponse():
        emit(state.copyWith(
          isLoading: false,
          questions: result.data,
          timeRemainingInSeconds: totalSeconds, 
        ));
        startTimer();
      case ErrorResponse():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage.isNotEmpty 
              ? result.errorMessage 
              : 'Something went wrong, please try again.',
        ));
    }
  }

  void selectAnswer(String questionId, String answerId) {
    final Map<String, String> newAnswers = Map.from(state.userAnswers);
    newAnswers[questionId] = answerId;
    emit(state.copyWith(userAnswers: newAnswers));
  }

  void nextQuestion() {
    if (state.currentIndex < state.questions.length - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void previousQuestion() {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      doEvent(TimeTickEvent());
    });
  }

  void onTimeTick() {
    if (state.timeRemainingInSeconds > 0) {
      emit(state.copyWith(timeRemainingInSeconds: state.timeRemainingInSeconds - 1));
    } else if (state.timeRemainingInSeconds == 0) {
      timer?.cancel();
    }
  }

  Future<void> finishExam(String examId) async {
    timer?.cancel();
    emit(state.copyWith(isSubmitting: true, isFinished: true));

    final answersList = state.userAnswers.entries
        .map((e) => AnswerItemRequest(questionId: e.key, correct: e.value))
        .toList();

    final elapsedSeconds = state.questions.isNotEmpty 
        ? (state.timeRemainingInSeconds >= 0 ? state.timeRemainingInSeconds : 0)
        : 0;
    final totalDurationSeconds = state.timeRemainingInSeconds + elapsedSeconds;
    final elapsedMinutes = ((totalDurationSeconds - state.timeRemainingInSeconds) / 60).ceil();
        
    final request = CheckAnswersRequest(answers: answersList, time: elapsedMinutes > 0 ? elapsedMinutes : 1);
    
    final result = await checkExamAnswersUseCase(request);
    
    switch (result) {
      case SuccessResponse():
        emit(state.copyWith(
          isSubmitting: false,
          score: result.data,
        ));
      case ErrorResponse():
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: result.errorMessage,
        ));
    }
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}

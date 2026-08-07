import 'dart:async';
import 'package:exam_app/config/base/base_response.dart';
import 'package:exam_app/core/constant/app_string.dart';
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
  Timer? _timer;

  QuestionsViewModel(
    this.getExamQuestionsUseCase,
    this.checkExamAnswersUseCase,
  ) : super(const QuestionsState());

  void doEvent(QuestionsEvent event) {
    switch (event) {
      case GetQuestionsEvent():
        _getQuestions(event.examId, event.duration);
        break;
      case SelectAnswerEvent():
        _selectAnswer(event.questionId, event.answerId);
        break;
      case NextQuestionEvent():
        _nextQuestion();
        break;
      case PreviousQuestionEvent():
        _previousQuestion();
        break;
      case TimeTickEvent():
        _onTimeTick();
        break;
      case FinishExamEvent():
        _finishExam(event.examId);
        break;
    }
  }

  Future<void> _getQuestions(String examId, String duration) async {
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
          data: result.data,
          timeRemainingInSeconds: totalSeconds,
        ));
        _startTimer();
      case ErrorResponse():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.errorMessage.isNotEmpty
              ? result.errorMessage
              : AppString.somethingWentWrong,
        ));
    }
  }

  void _selectAnswer(String questionId, String answerId) {
    final Map<String, String> newAnswers = Map.from(state.userAnswers);
    newAnswers[questionId] = answerId;
    emit(state.copyWith(userAnswers: newAnswers));
  }

  void _nextQuestion() {
    if (state.currentIndex < (state.data?.length ?? 0) - 1) {
      emit(state.copyWith(currentIndex: state.currentIndex + 1));
    }
  }

  void _previousQuestion() {
    if (state.currentIndex > 0) {
      emit(state.copyWith(currentIndex: state.currentIndex - 1));
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      _onTimeTick();
    });
  }

  void _onTimeTick() {
    if (state.timeRemainingInSeconds > 0) {
      emit(state.copyWith(timeRemainingInSeconds: state.timeRemainingInSeconds - 1));
    } else if (state.timeRemainingInSeconds == 0) {
      _timer?.cancel();
    }
  }

  Future<void> _finishExam(String examId) async {
    _timer?.cancel();
    emit(state.copyWith(isSubmitting: true, isFinished: true));

    final answersList = state.userAnswers.entries
        .map((e) => AnswerItemRequest(questionId: e.key, correct: e.value))
        .toList();

    final request = CheckAnswersRequest(answers: answersList, time: 1);

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
    _timer?.cancel();
    return super.close();
  }
}

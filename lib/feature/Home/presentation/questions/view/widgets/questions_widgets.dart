import 'package:exam_app/core/constant/app_string.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/feature/Home/domain/entity/question_entity.dart';
import 'package:exam_app/feature/Home/presentation/questions/view_model/questions_event.dart';
import 'package:exam_app/feature/Home/presentation/questions/view_model/questions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswersList extends StatelessWidget {
  final QuestionEntity question;
  final Map<String, String> userAnswers;
  final String examId;

  const AnswersList({
    super.key,
    required this.question,
    required this.userAnswers,
    required this.examId,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final selectedAnswerId = userAnswers[question.id];

    return ListView.separated(
      itemCount: question.answers.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final answer = question.answers[index];
        final isSelected = selectedAnswerId == answer.key;

        return InkWell(
          onTap: () => context.read<QuestionsViewModel>().doEvent(
                SelectAnswerEvent(questionId: question.id, answerId: answer.key),
              ),
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: isSelected ? colors.blue.withValues(alpha: 0.1) : colors.unselectedAnswer,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected ? colors.blue : Colors.transparent,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: isSelected ? colors.blue : colors.grey,
                  size: 20.r,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    answer.answerText,
                    style: TextStyle(fontSize: 14.sp, color: colors.black),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ActionButtons extends StatelessWidget {
  final int currentIndex;
  final bool isLastQuestion;
  final bool hasAnswered;
  final String examId;

  const ActionButtons({
    super.key,
    required this.currentIndex,
    required this.isLastQuestion,
    required this.hasAnswered,
    required this.examId,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              side: BorderSide(color: colors.blue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: currentIndex > 0
                ? () => context.read<QuestionsViewModel>().doEvent(PreviousQuestionEvent())
                : null,
            child: Text(
              AppString.back,
              style: TextStyle(color: currentIndex > 0 ? colors.blue : colors.grey),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: hasAnswered ? colors.blue : colors.blue.withValues(alpha: 0.4),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            onPressed: hasAnswered
                ? () {
                    if (isLastQuestion) {
                      context.read<QuestionsViewModel>().doEvent(FinishExamEvent(examId));
                    } else {
                      context.read<QuestionsViewModel>().doEvent(NextQuestionEvent());
                    }
                  }
                : null,
            child: Text(
              isLastQuestion ? AppString.finish : AppString.next,
              style: TextStyle(color: colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:exam_app/core/constant/app_string.dart';
import 'package:exam_app/core/extensions/time_extension.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/feature/Home/presentation/questions/view/widgets/questions_widgets.dart';
import 'package:exam_app/feature/Home/presentation/questions/view_model/questions_event.dart';
import 'package:exam_app/feature/Home/presentation/questions/view_model/questions_state.dart';
import 'package:exam_app/feature/Home/presentation/questions/view_model/questions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';

class QuestionsScreen extends StatefulWidget {
  final String examId;
  final String duration;
  const QuestionsScreen({super.key, required this.examId, this.duration = '30'});

  @override
  State<QuestionsScreen> createState() => QuestionsScreenState();
}

class QuestionsScreenState extends State<QuestionsScreen> {
  bool timeoutDialogShown = false;

  @override
  void initState() {
    super.initState();
    context.read<QuestionsViewModel>().doEvent(GetQuestionsEvent(widget.examId, widget.duration));
  }

  void showTimeoutDialog(BuildContext context, AppColors colors) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        contentPadding: EdgeInsets.all(20.r),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.hourglass_empty, size: 50.r, color: colors.error),
            SizedBox(height: 10.h),
            Text(
              AppString.timeout,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: colors.error),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.pop();
                  context.read<QuestionsViewModel>().doEvent(FinishExamEvent(widget.examId));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text(AppString.viewScore),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return BlocListener<QuestionsViewModel, QuestionsState>(
      listener: (context, state) {
        if (state.timeRemainingInSeconds == 0 &&
            (state.data?.isNotEmpty ?? false) &&
            !state.isFinished &&
            !timeoutDialogShown) {
          timeoutDialogShown = true;
          showTimeoutDialog(context, colors);
        }
        if (state.score != null && !state.isSubmitting) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.pushReplacementNamed(AppRoutesNamed.scoreScreen, extra: state.score);
            }
          });
        }
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage), backgroundColor: colors.error),
          );
        }
      },
      child: BlocBuilder<QuestionsViewModel, QuestionsState>(
        buildWhen: (prev, curr) => prev.isLoading != curr.isLoading || (prev.data == null && curr.data != null),
        builder: (context, state) {
          if (state.isLoading) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          if (state.data == null || state.data!.isEmpty) {
            return Scaffold(
              appBar: AppBar(leading: const BackButton()),
              body: Center(child: Text(AppString.noQuestionsFound)),
            );
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
                onPressed: () => context.pop(),
              ),
              title: Text(AppString.exam),
              actions: [
                BlocSelector<QuestionsViewModel, QuestionsState, int>(
                  selector: (state) => state.timeRemainingInSeconds,
                  builder: (context, timeRemaining) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined, color: colors.success, size: 20.r),
                        SizedBox(width: 4.w),
                        Text(
                          timeRemaining.formatTime(),
                          style: TextStyle(color: colors.success, fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: BlocBuilder<QuestionsViewModel, QuestionsState>(
              buildWhen: (prev, curr) =>
                  prev.currentIndex != curr.currentIndex ||
                  prev.userAnswers != curr.userAnswers ||
                  prev.isSubmitting != curr.isSubmitting,
              builder: (context, state) {
                final questions = state.data!;
                final currentQuestion = questions[state.currentIndex];
                final isLastQuestion = state.currentIndex == questions.length - 1;
                final hasAnswered = state.userAnswers.containsKey(currentQuestion.id);

                return Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppString.questionOf(state.currentIndex + 1, questions.length),
                        style: TextStyle(color: colors.grey, fontSize: 14.sp),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        currentQuestion.questionText,
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: colors.black),
                      ),
                      SizedBox(height: 24.h),
                      Expanded(
                        child: AnswersList(
                          question: currentQuestion,
                          userAnswers: state.userAnswers,
                          examId: widget.examId,
                        ),
                      ),
                      if (state.isSubmitting)
                        const Center(child: CircularProgressIndicator())
                      else
                        ActionButtons(
                          currentIndex: state.currentIndex,
                          isLastQuestion: isLastQuestion,
                          hasAnswered: hasAnswered,
                          examId: widget.examId,
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

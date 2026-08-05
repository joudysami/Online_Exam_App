import 'package:exam_app/core/theme/app_colors.dart';
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
  const QuestionsScreen({super.key, required this.examId, this.duration = "30"});

  @override
  State<QuestionsScreen> createState() => QuestionsScreenState();
}

class QuestionsScreenState extends State<QuestionsScreen> {
  bool timeoutDialogShown = false;

  @override
  void initState() {
    super.initState();
    context.read<QuestionsViewModel>().getQuestions(widget.examId, widget.duration);
  }

  String formatTime(int seconds) {
    final int min = seconds ~/ 60;
    final int sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
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
              'Time out !!',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: colors.error,
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  context.pop();
                  context.read<QuestionsViewModel>().finishExam(widget.examId);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Text('View score', style: TextStyle(color: colors.white)),
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
    
    return BlocConsumer<QuestionsViewModel, QuestionsState>(
      listener: (context, state) {
        if (state.timeRemainingInSeconds == 0 &&
            state.questions.isNotEmpty &&
            !state.isFinished &&
            !timeoutDialogShown) {
          timeoutDialogShown = true;
          showTimeoutDialog(context, colors);
        }
        if (state.score != null && !state.isSubmitting) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.pushReplacementNamed(
                AppRoutesNamed.scoreScreen,
                extra: state.score,
              );
            }
          });
        }
        if (state.errorMessage.isNotEmpty) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage), backgroundColor: colors.error),
          );
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (state.questions.isEmpty) {
          return Scaffold(
            appBar: AppBar(leading: const BackButton()),
            body: const Center(child: Text("No questions found.")),
          );
        }

        final currentQuestion = state.questions[state.currentIndex];
        final isLastQuestion = state.currentIndex == state.questions.length - 1;
        final hasAnswered = state.userAnswers.containsKey(currentQuestion.id);

        return Scaffold(
          backgroundColor: colors.white,
          appBar: AppBar(
            backgroundColor: colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: colors.black, size: 20.r),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Exam',
              style: TextStyle(color: colors.black, fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            actions: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Icon(Icons.timer_outlined, color: colors.success, size: 20.r),
                      SizedBox(width: 4.w),
                      Text(
                        formatTime(state.timeRemainingInSeconds),
                        style: TextStyle(
                          color: colors.success,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Question ${state.currentIndex + 1} of ${state.questions.length}',
                      style: TextStyle(
                        color: colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  currentQuestion.questionText,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.black,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: currentQuestion.answers.length,
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      final answer = currentQuestion.answers[index];
                      final isSelected = state.userAnswers[currentQuestion.id] == answer.id;
                      
                      return InkWell(
                        onTap: () {
                          context.read<QuestionsViewModel>().selectAnswer(
                                currentQuestion.id,
                                answer.id,
                              );
                        },
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                          decoration: BoxDecoration(
                            color: isSelected ? colors.blue.withOpacity(0.1) : colors.unselectedAnswer,
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
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (state.isSubmitting)
                  const Center(child: CircularProgressIndicator())
                else
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            side: BorderSide(color: colors.blue),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                          ),
                          onPressed: state.currentIndex > 0
                              ? () => context.read<QuestionsViewModel>().previousQuestion()
                              : null,
                          child: Text('Back', style: TextStyle(color: state.currentIndex > 0 ? colors.blue : colors.grey)),
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
                                    context.read<QuestionsViewModel>().finishExam(widget.examId);
                                  } else {
                                    context.read<QuestionsViewModel>().nextQuestion();
                                  }
                                }
                              : null,
                          child: Text(
                            isLastQuestion ? 'Finish' : 'Next',
                            style: TextStyle(color: colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

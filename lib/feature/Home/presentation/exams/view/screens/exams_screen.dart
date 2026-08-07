import 'package:exam_app/config/base/base_state.dart';
import 'package:exam_app/core/constant/app_string.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/feature/Home/data/models/exam_details_args.dart';
import 'package:exam_app/feature/Home/domain/entity/exam_entity.dart';
import 'package:exam_app/feature/Home/presentation/exams/view/widgets/exam_card.dart';
import 'package:exam_app/feature/Home/presentation/exams/view_model/exam_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ExamsScreen extends StatefulWidget {
  final String subjectId;
  final String subjectName;
  final String subjectIcon;
  const ExamsScreen({
    super.key,
    required this.subjectId,
    required this.subjectName,
    required this.subjectIcon,
  });

  @override
  State<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends State<ExamsScreen> {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 20.r,
                      color: colors.black,
                    ),
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                    },
                  ),
                  Text(
                    widget.subjectName,
                    style: TextStyle(
                      color: colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ExamsViewModel, BaseState<List<ExamEntity>>>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.errorMessage.isNotEmpty) {
                    return Center(child: Text(state.errorMessage));
                  }
                  if (state.data != null) {
                    final exams = state.data!;
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10.h);
                      },
                      itemCount: exams.length,
                      itemBuilder: (context, index) {
                        final exam = exams[index];
                        return ExamCard(
                          title: exam.title,
                          duration: exam.duration.toString(),
                          numberOfQuestions: exam.numberOfQuestions.toString(),
                          subjectIcon: widget.subjectIcon,
              
                          onTap: () {
                            context.pushNamed(
                              AppRoutesNamed.startExam,
                              extra: ExamDetailsArgs(
                                examId: exam.id,
                                subjectId: widget.subjectId,
                                subjectName: widget.subjectName,
                                subjectIcon: widget.subjectIcon,
                          duration: exam.duration.toString(),
                          numberOfQuestions: exam.numberOfQuestions.toString(),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: Text(AppString.noExamsFound));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

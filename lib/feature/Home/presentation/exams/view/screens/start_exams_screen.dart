import 'package:exam_app/core/constant/app_icons.dart';
import 'package:exam_app/core/constant/app_string.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/core/widgets/custom_button.dart';
import 'package:exam_app/feature/Home/presentation/exams/view/widgets/instruction_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class StartExamScreen extends StatelessWidget {
  final String subjectId;
  final String subjectName;
  final String subjectIcon;
  final String duration;
  final String numberOfQuestions;

  const StartExamScreen({
    super.key,
    required this.subjectIcon,
    required this.subjectId,
    required this.subjectName,
    required this.duration,
    required this.numberOfQuestions,
  });

  static const List<String> _instructions = [
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
    'Lorem ipsum dolor sit amet consectetur.',
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.w, top: 8.h, bottom: 4.h),
              child: IconButton(
                icon: Icon(AppIcons.arrowBack, size: 20.r, color: colors.black),
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  }
                },
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          subjectIcon,
                          width: 60.w,
                          height: 60.h,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          subjectName,
                          style: TextStyle(
                            color: colors.blue[500] ?? colors.blue,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Text(
                          duration,
                          style: TextStyle(
                            color: colors.blue[500] ?? colors.blue,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    Row(
                      children: [
                        Text(
                          AppString.highLevel,
                          style: TextStyle(
                            color: colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Container(
                            width: 1.5.w,
                            height: 16.h,
                            color: colors.grey.withValues(alpha: 0.5),
                          ),
                        ),

                        Text(
                          " $numberOfQuestions questions",
                          style: TextStyle(
                            color: colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    Divider(
                      color: colors.grey.withValues(alpha: 0.2),
                      thickness: 2,
                    ),

                    SizedBox(height: 20.h),

                    Text(
                      AppString.instructions,
                      style: TextStyle(
                        color: colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Column(
                      children: [
                        for (final text in _instructions)
                          InstructionItem(text: text),
                      ],
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(text: AppString.startExam, onTap: () {}),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

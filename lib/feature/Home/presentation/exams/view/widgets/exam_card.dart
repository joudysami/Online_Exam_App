import 'package:exam_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String subjectIcon;
  final String duration;
  final String numberOfQuestions;
  const ExamCard({
    super.key,
    this.onTap,
    required this.subjectIcon,
    required this.title,
    required this.duration,
    required this.numberOfQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: colors.grey.withValues(alpha: 0.15),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.black.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              subjectIcon,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        duration,
                        style: TextStyle(
                          color: colors.blue[500] ?? colors.blue,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${numberOfQuestions} Question',
                    style: TextStyle(
                      color: colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

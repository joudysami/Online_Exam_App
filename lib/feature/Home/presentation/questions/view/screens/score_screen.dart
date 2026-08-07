import 'package:exam_app/core/constant/app_string.dart';
import 'package:exam_app/core/theme/app_colors.dart';
import 'package:exam_app/feature/Home/domain/entity/score_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ScoreScreen extends StatelessWidget {
  final ScoreEntity score;
  const ScoreScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final double percentage = score.total > 0
        ? (score.correct / score.total)
        : 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, size: 20.r),
          onPressed: () => context.pop(),
        ),
        title: Text(AppString.examScore),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppString.result,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: colors.black),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120.r,
                      height: 120.r,
                      child: CircularProgressIndicator(
                        value: percentage,
                        strokeWidth: 10.r,
                        color: colors.blue,
                        backgroundColor: colors.blue.withValues(alpha: 0.1),
                      ),
                    ),
                    Text(
                      '${(percentage * 100).toInt()}%',
                      style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: colors.blue),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ScoreRow(label: 'Correct', count: score.correct, color: colors.blue),
                    SizedBox(height: 20.h),
                    _ScoreRow(label: 'Incorrect', count: score.incorrect, color: colors.error),
                  ],
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.pop(),
                child: Text(AppString.startExam),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  side: BorderSide(color: colors.blue),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                ),
                onPressed: () => context.pop(),
                child: Text(AppString.startExam, style: TextStyle(color: colors.blue, fontSize: 16.sp)),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _ScoreRow({required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: color, fontSize: 16.sp, fontWeight: FontWeight.w500)),
        SizedBox(width: 20.w),
        CircleAvatar(
          radius: 12.r,
          backgroundColor: color.withValues(alpha: 0.1),
          child: Text('$count', style: TextStyle(color: color, fontSize: 12.sp)),
        ),
      ],
    );
  }
}



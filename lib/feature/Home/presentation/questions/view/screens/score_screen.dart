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
      backgroundColor: colors.white,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colors.black, size: 20.r),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Exam score',
          style: TextStyle(color: colors.black, fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your score',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: colors.black,
              ),
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
                        backgroundColor: colors.blue.withOpacity(0.1),
                      ),
                    ),
                    Text(
                      '${(percentage * 100).toInt()}%',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: colors.blue,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Correct', style: TextStyle(color: colors.blue, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                        SizedBox(width: 20.w),
                        CircleAvatar(
                          radius: 12.r,
                          backgroundColor: colors.blue.withOpacity(0.1),
                          child: Text('${score.correct}', style: TextStyle(color: colors.blue, fontSize: 12.sp)),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Text('Incorrect', style: TextStyle(color: colors.error, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                        SizedBox(width: 12.w),
                        CircleAvatar(
                          radius: 12.r,
                          backgroundColor: colors.error.withOpacity(0.1),
                          child: Text('${score.incorrect}', style: TextStyle(color: colors.error, fontSize: 12.sp)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                ),
                onPressed: () {
                  // Show results logic if available, for now just pop
                  context.pop();
                },
                child: Text('Show results', style: TextStyle(color: colors.white, fontSize: 16.sp)),
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
                onPressed: () {
                  // Restart exam logic, can just pop back to exam details
                  context.pop();
                },
                child: Text('Start again', style: TextStyle(color: colors.blue, fontSize: 16.sp)),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

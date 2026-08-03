import 'package:exam_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructionItem extends StatelessWidget {
  final String text;

  InstructionItem({required this.text});
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 10.w),
            child: Container(
              width: 5.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

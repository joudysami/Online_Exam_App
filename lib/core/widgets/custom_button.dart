import 'package:exam_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap});
  final String text;
 final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
     final colors = context.colors;
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: colors.white,
        ),
      ),
    );
  }
}

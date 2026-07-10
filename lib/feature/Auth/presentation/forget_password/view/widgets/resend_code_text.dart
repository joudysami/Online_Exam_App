import 'package:exam_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendCodeText extends StatelessWidget {
  final VoidCallback? onResendPressed;

  const ResendCodeText({super.key, this.onResendPressed});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive code? ",
          style: TextStyle(fontSize: 16.sp, color: colors.black[400]),
        ),
        GestureDetector(
          onTap: onResendPressed,
          child: Text(
            'Resend',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: colors.blue[400],
              decoration: TextDecoration.underline,
              decorationColor: colors.blue[400],
            ),
          ),
        ),
      ],
    );
  }
}

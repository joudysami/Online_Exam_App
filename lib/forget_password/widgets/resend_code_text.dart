import 'package:flutter/material.dart';

class ResendCodeText extends StatelessWidget {
  final VoidCallback? onResendPressed;

  const ResendCodeText({
    super.key,
    this.onResendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Didn't receive code? ",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        GestureDetector(
          onTap: onResendPressed,
          child: const Text(
            'Resend',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF02369C),
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF02369C),
            ),
          ),
        ),
      ],
    );
  }
}

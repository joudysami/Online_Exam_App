import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeInput extends StatelessWidget {
  final PinInputController pinController;
  final bool hasError;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;

  const PinCodeInput({
    super.key,
    required this.pinController,
    this.hasError = false,
    this.onChanged,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialPinField(
      length: 4,
      pinController: pinController,
      onChanged: onChanged,
      onCompleted: onCompleted,
      keyboardType: TextInputType.number,
      theme: MaterialPinTheme(
        shape: MaterialPinShape.outlined,
        cellSize:  Size(74.w, 68.h),
        spacing: 16.dg,
        borderRadius: BorderRadius.circular(10.r),
        borderWidth: 1.5,
        focusedBorderWidth: 2.0,

        borderColor: hasError
            ? theme.colorScheme.error
            : theme.colorScheme.primary,

        focusedBorderColor: hasError
            ? theme.colorScheme.error
            : theme.colorScheme.primary,

        filledBorderColor: hasError
            ? theme.colorScheme.error
            : theme.colorScheme.primary,

        fillColor: theme.colorScheme.surface,
        focusedFillColor: theme.colorScheme.surface,
        filledFillColor: theme.colorScheme.surface,

        textStyle: theme.textTheme.titleLarge!.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.w600,
        ),

        cursorColor: theme.colorScheme.primary,
        entryAnimation: MaterialPinAnimation.fade,
        animationDuration: const Duration(milliseconds: 200),
        enableErrorShake: true,
      ),
    );
  }
}

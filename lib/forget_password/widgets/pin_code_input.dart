import 'package:flutter/material.dart';
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
    return MaterialPinField(
      length: 4,
      pinController: pinController,
      onChanged: onChanged,
      onCompleted: onCompleted,
      keyboardType: TextInputType.number,
      theme: MaterialPinTheme(
        shape: MaterialPinShape.outlined,
        cellSize: const Size(60, 60),
        spacing: 16,
        borderRadius: BorderRadius.circular(10),
        borderWidth: 1.5,
        focusedBorderWidth: 2.0,
        borderColor: hasError ? Colors.red : const Color(0xFF02369C),
        focusedBorderColor: hasError ? Colors.red : const Color(0xFF02369C),
        filledBorderColor: hasError ? Colors.red : const Color(0xFF02369C),
        errorColor: Colors.red,
        fillColor: Colors.white,
        focusedFillColor: Colors.white,
        filledFillColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        showCursor: true,
        cursorColor: const Color(0xFF02369C),
        entryAnimation: MaterialPinAnimation.fade,
        animationDuration: const Duration(milliseconds: 200),
        enableErrorShake: true,
      ),
    );
  }
}

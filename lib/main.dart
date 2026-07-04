import 'package:flutter/material.dart';
import 'package:exam_app/forget_password/screens/forget_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF02369C)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const ForgetPasswordScreen(),
    );
  }
}

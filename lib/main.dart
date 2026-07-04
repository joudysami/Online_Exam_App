import 'package:exam_app/config/routes/app_routes.dart';
import 'package:exam_app/config/routes/app_routes_named.dart';
import 'package:exam_app/config/theme/theme_provider.dart';
import 'package:exam_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main (){
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 884),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
         
          themeMode: context.watch<ThemeProvider>().themeMode,
          initialRoute: AppRoutesNamed.login,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
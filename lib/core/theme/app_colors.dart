import 'package:flutter/material.dart';

abstract class AppColors {
  Color get error;
  Color get focusBlue;
  Color get white;
  Color get grey;
  Color get disabledButton;
  Color get shadow;
  Color get success;
  Color get unselectedAnswer;
 MaterialColor get blue;
 MaterialColor get black;
 Brightness get brightness ;
}

class LightThemeColor extends AppColors {
  @override
  MaterialColor get black => MaterialColor(
    0xFF0F0F0F, 
    <int, Color>{
      50: Color(0xFFCFCFCF),  
      100: Color(0xFFAFAFAF),  
      200: Color(0xFF878787), 
      300: Color(0xFF5F5F5F), 
      400: Color(0xFF373737),  
      500: Color(0xFF0F0F0F),  
      600: Color(0xFF0D0D0D),  
      700: Color(0xFF0A0A0A), 
      800: Color(0xFF080808),  
      900: Color(0xFF050505),  
      950: Color(0xFF030303),  
    },
  );
  @override
  MaterialColor get blue => MaterialColor(
    0xFF02369C, 
    <int, Color>{
      50: Color(0xFFCCD7EB),   
      100: Color(0xFFABBCDE),  
      200: Color(0xFF818BCE),  
      300: Color(0xFF5679BD),  
      400: Color(0xFF2C58AD),  
      500: Color(0xFF02369C),  
      600: Color(0xFF022D82), 
      700: Color(0xFF012488),  
      800: Color(0xFF011B4E),  
      900: Color(0xFF011234),  
      950: Color(0xFF000B1F),  
    },
  );
  @override
  Color get disabledButton =>  Color(0xff878787);
  @override 
  Color get error => Color(0xFFCC1010);
  @override
  Color get focusBlue => Color(0xff5679BD);
  @override
  Color get grey => Color(0xffA6A6A6);
  @override
  Color get shadow =>  Color(0xFFABBCDE);
  @override
  Color get success => Color(0xff11CE19);
  @override
  Color get unselectedAnswer =>  Color(0xFFEDEFF3); 
  @override
  Color get white =>Color(0xFFFFFFFF);
  @override
  Brightness get brightness => Brightness.light;

}
class DarkThemeColor extends AppColors {
   @override
  MaterialColor get black => MaterialColor(
    0xFF0F0F0F, 
    <int, Color>{
      50: Color(0xFFCFCFCF),  
      100: Color(0xFFAFAFAF),  
      200: Color(0xFF878787), 
      300: Color(0xFF5F5F5F), 
      400: Color(0xFF373737),  
      500: Color(0xFF0F0F0F),  
      600: Color(0xFF0D0D0D),  
      700: Color(0xFF0A0A0A), 
      800: Color(0xFF080808),  
      900: Color(0xFF050505),  
      950: Color(0xFF030303),  
    },
  );
  @override
  MaterialColor get blue => MaterialColor(
    0xFF02369C, 
    <int, Color>{
      50: Color(0xFFCCD7EB),   
      100: Color(0xFFABBCDE),  
      200: Color(0xFF818BCE),  
      300: Color(0xFF5679BD),  
      400: Color(0xFF2C58AD),  
      500: Color(0xFF02369C),  
      600: Color(0xFF022D82), 
      700: Color(0xFF012488),  
      800: Color(0xFF011B4E),  
      900: Color(0xFF011234),  
      950: Color(0xFF000B1F),  
    },
  );
  @override
  Color get disabledButton =>  Color(0xff878787);
  @override 
  Color get error => Color(0xFFCC1010);
  @override
  Color get focusBlue => Color(0xff5679BD);
  @override
  Color get grey => Color(0xffA6A6A6);
  @override
  Color get shadow =>  Color(0xFFABBCDE);
  @override
  Color get success => Color(0xff11CE19);
  @override
  Color get unselectedAnswer =>  Color(0xFFEDEFF3); 
  @override
  Color get white =>Color(0xFFFFFFFF);
  @override
  Brightness get brightness => Brightness.dark;

}

extension ThemeColors on BuildContext {
  AppColors get colors => Theme.of(this).brightness == Brightness.light
      ? LightThemeColor()
      : DarkThemeColor();
}
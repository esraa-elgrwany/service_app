import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
class MyThemeData{

  static ThemeData lightTheme=ThemeData(
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary:primaryColor, onPrimary:Colors.white, secondary:greyColor,
          onSecondary:thirdPrimary, error: Colors.red, onError:Colors.white,
          background:Colors.white,
          onBackground: Colors.grey[100],
          surface:Colors.white,
          onSurface:Colors.black),

      scaffoldBackgroundColor:Colors.white,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,actionsIconTheme: IconThemeData(
          color:Colors.black
      )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent
      )
  );

  static ThemeData darkTheme=ThemeData(
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary:Colors.white, onPrimary: Colors.white, secondary:Colors.white,
          onSecondary:Colors.white, error: Colors.red, onError:Colors.white,
          background:darkGrey,
          onBackground:darkGrey,
          surface:primaryColor,
          onSurface:Colors.white),

      scaffoldBackgroundColor:Colors.black87 ,
      appBarTheme: AppBarTheme(
          backgroundColor:Colors.black87 ,
          elevation: 0,
          shadowColor: Colors.transparent,
          actionsIconTheme: IconThemeData(
              color:Colors.white
          )
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent
      )
  );
}

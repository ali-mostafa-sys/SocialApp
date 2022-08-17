import 'package:flutter/material.dart';
import 'package:social/shared/components/constants.dart';

ThemeData lightTheme = ThemeData(


  primaryColor: Colors.white,
  primarySwatch: Colors.blue,
  backgroundColor: Colors.white,

  scaffoldBackgroundColor: Colors.white,
  iconTheme:const IconThemeData(
    color: Colors.black,
  ),

  appBarTheme:const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    )
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    
    backgroundColor: Colors.white,
    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.blue.withOpacity(0.5),
    elevation: 25,
    selectedIconTheme: IconThemeData(
        size: 30,
      color: Colors.blue
    ),
    unselectedIconTheme: IconThemeData(
        size: 20,
      color: Colors.blue.withOpacity(0.5),
    ),
  ),
  textTheme:const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black
    ),
    subtitle1: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600
    ),
    caption: TextStyle(
      color: Colors.grey
    )
  ),
  cardTheme:const CardTheme(
    color: Colors.white
  ),
);


ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    primarySwatch: Colors.blue,
    backgroundColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    iconTheme:const IconThemeData(
      color: Colors.white,
    ),
    appBarTheme:const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0.0,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        )
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,

      backgroundColor: Colors.black,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.blue.withOpacity(0.5),
      elevation: 25,
      selectedIconTheme:const IconThemeData(
          size: 30,
          color: Colors.blue
      ),
      unselectedIconTheme: IconThemeData(
        size: 20,
        color: Colors.blue.withOpacity(0.5),
      ),
    ),
    textTheme:const TextTheme(
      bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white
      ),
      subtitle1: TextStyle(
          color: Colors.white ,
          fontSize: 14,
          fontWeight: FontWeight.w600
      ),
        caption: TextStyle(
            color: Colors.white
        )
    ),
  cardTheme:const CardTheme(
      color: Colors.black
  ),
);

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';


ThemeData darkTheme=ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    textTheme: TextTheme(
      bodyText1:GoogleFonts.comfortaa(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      bodyText2: GoogleFonts.comfortaa(
        color: Colors.white,
        fontWeight: FontWeight.w200,
        fontSize: 15,
      ),
    ),
    scaffoldBackgroundColor: HexColor('333739'),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: HexColor('333739'),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          statusBarColor: HexColor('333739'),
        ),
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        )
    ),
    cardColor: HexColor('333739'),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('333739'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red.withOpacity(0.7),
      unselectedItemColor: Colors.grey[600],
    )
);

ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black87,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    textTheme: TextTheme(
      bodyText1:GoogleFonts.comfortaa(
        color: Colors.black87,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      bodyText2: GoogleFonts.comfortaa(
        color: Colors.black87,
        fontWeight: FontWeight.w200,
        fontSize: 15,
      ),
    ),
    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,
        ),
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.red.withOpacity(0.7),
      unselectedItemColor: Colors.grey[600],
    )
);
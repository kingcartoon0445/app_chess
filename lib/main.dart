import 'package:app_chess/bloc/app_blocs.dart';
import 'package:app_chess/screens/game_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  createAppBlocs();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chess Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.barlowCondensed().fontFamily,
        primaryColor: Color(0xFFAD7753), // Màu chính của ứng dụng
        brightness: Brightness.light, // Giao diện sáng
        textTheme: TextTheme(
          displayLarge: GoogleFonts.barlowCondensed(
              fontSize: 59,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 36, color: Colors.black), // Thiết lập kiểu chữ
          titleMedium: TextStyle(
              fontSize: 26,
              color: Color(0xFFAD7753),
              fontWeight: FontWeight.w600),
          titleSmall: TextStyle(
              fontSize: 16,
              color: Color(0xFFAD7753),
              fontWeight: FontWeight.w600),
          labelMedium: TextStyle(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),

          labelSmall: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(fontSize: 20, color: Color(0xFFAD7753)),
        ),
      ),
      home: const GameScreen(),
    );
  }
}

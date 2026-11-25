// เริ่มตั้งแต่บรรทัดที่ 1 ถึงบรรทัดสุดท้ายของไฟล์ lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'views/splash_screen_ui.dart';

void main() {
  runApp(const BodyHealthCalculatorApp());
}

class BodyHealthCalculatorApp extends StatelessWidget {
  const BodyHealthCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Body ว้าว',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        textTheme: GoogleFonts.kanitTextTheme(),
        useMaterial3: true,
      ),
      home: const SplashScreenUI(),
    );
  }
}

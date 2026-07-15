import 'package:airbnb_clone/screens/home_screen.dart';
import 'package:airbnb_clone/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Airbnb_Clone",
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        scaffoldBackgroundColor: AppColors.lightBackground,

        colorScheme: ColorScheme.light(
          primary: AppColors.accentRed,
          secondary: Colors.deepPurple.shade100,
          onSecondary: Colors.black,
          surface: AppColors.lightSurface,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),

      // ================= DARK THEME ===================
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        scaffoldBackgroundColor: AppColors.darkBackground,

        colorScheme: ColorScheme.dark(
          primary: AppColors.accentRed,
          secondary: Colors.deepPurple,
          onSecondary: Colors.white,
          surface: AppColors.darkSurface,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
        ),

        cardTheme: CardThemeData(
          color: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class AppColors {
  // Dark theme colors
  // change colors as per your preference
  static const Color darkBackground = Color(0xFF0D0D0D);
  static const Color darkSurface = Color(0xFF1A1A1A);

  static const Color accentRed = Color(0xFFCD456A);
  static const Color grey = Color.fromARGB(255, 180, 180, 180);
  static const Color lightgrey = Color.fromARGB(255, 234, 234, 234);

  // Light theme colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Colors.white;
}

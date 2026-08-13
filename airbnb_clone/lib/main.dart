import 'package:airbnb_clone/main_screen/login_screen.dart';
import 'package:airbnb_clone/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
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

        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),

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
          scrolledUnderElevation: 0,
        ),

        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 14),
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

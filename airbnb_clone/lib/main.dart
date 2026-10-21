import 'package:airbnb_clone/main_screen/login_screen.dart';
import 'package:airbnb_clone/providers/experience_provider.dart';
import 'package:airbnb_clone/providers/home_provider.dart';
import 'package:airbnb_clone/providers/service_provider.dart';
import 'package:airbnb_clone/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:airbnb_clone/main_screen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(create: (_) => HomeProvider()),
        ChangeNotifierProvider<ExperienceProvider>(
          create: (_) => ExperienceProvider(),
        ),
        ChangeNotifierProvider<ServiceProvider>(
          create: (_) => ServiceProvider(),
        ),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> getSavedUserName() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'jwt_token');

    if (token == null || token.isEmpty) return null;

    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName') ?? 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Airbnb_Clone",
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<String?>(
        future: getSavedUserName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasError || snapshot.data == null) {
            return const LoginScreen();
          }

          return HomePage(userName: snapshot.data);
        },
      ),
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
  static const Color darkgrey = Color.fromARGB(255, 119, 119, 119);
  static const Color accentRed = Color(0xFFCD456A);
  static const Color grey = Color.fromARGB(255, 180, 180, 180);
  static const Color lightgrey = Color.fromARGB(255, 234, 234, 234);

  // Light theme colors
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Colors.white;
}

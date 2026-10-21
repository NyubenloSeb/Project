import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:airbnb_clone/main.dart';
import 'package:airbnb_clone/main_screen/home_page.dart';
import 'package:airbnb_clone/widgets/custom_field.dart';
import 'package:airbnb_clone/util/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:airbnb_clone/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> login() async {
    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(awsUri),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('userName', data['user']['name']);

        const storage = FlutterSecureStorage();

        await storage.write(key: 'jwt_token', value: token);

        if (!mounted) return;

        await context.read<WishlistProvider>().fetchWishlist();

        if (!mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(userName: data['user']['name']),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Login failed')),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not connect to server')),
        );
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.lightgrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (route) => false,
                    );
                  },
                ),
              ),

              const SizedBox(height: 150),

              Image.network(
                "https://logos-world.net/wp-content/uploads/2020/07/Airbnb-Emblem.png",
                height: 100,
              ),
              const SizedBox(height: 30),

              const Text(
                "Log in or Sign up",
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),

              CustomField(controller: emailController),
              const SizedBox(height: 5),
              CustomFieldPassword(controller: passwordController),

              SizedBox(
                height: 57,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Continue",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.grey)),
                  const Text(
                    "or",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Expanded(child: Divider(color: AppColors.grey)),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.lightBackground,
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network(
                      "https://e7.pngegg.com/pngimages/882/225/png-clipart-google-logo-google-logo-google-search-icon-google-text-logo.png",
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.lightBackground,
                      border: Border.all(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHSNHkeNc0diVXPGsKYnJy1i30NWu4iiYQsJiXhvlpNbR7g8Yn5YixaHo&s=10",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

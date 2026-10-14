import 'package:airbnb_clone/main.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final TextEditingController controller;

  const CustomField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightBackground,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey, width: 1.2),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: 'Email',
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

class CustomFieldPassword extends StatefulWidget {
  final TextEditingController controller;

  const CustomFieldPassword({super.key, required this.controller});

  @override
  State<CustomFieldPassword> createState() => _CustomFieldPasswordState();
}

class _CustomFieldPasswordState extends State<CustomFieldPassword> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightBackground,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.grey, width: 1.2),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.accentRed, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: 'Enter your password',
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
            onPressed: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
          ),
        ),
      ),
    );
  }
}

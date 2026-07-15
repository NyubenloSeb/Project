import 'package:airbnb_clone/main.dart';
import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.lightBackground,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.grey, width: 1.2),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Phone Number or Email',
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:airbnb_clone/main.dart';
import 'package:airbnb_clone/main_screen/home_page.dart';
import 'package:airbnb_clone/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightgrey,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(height: 270),
            //The logo
            Image.network(
              "https://logos-world.net/wp-content/uploads/2020/07/Airbnb-Emblem.png",
              height: 100,
            ),
            SizedBox(height: 30),
            Text(
              "Log in or Sign up",
              style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            //TextField
            CustomField(),

            //Button
            SizedBox(
              height: 57,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text("Continue", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(child: Divider(color: AppColors.grey)),
                Text("or", style: TextStyle(fontSize: 18)),
                Expanded(child: Divider(color: AppColors.grey)),
              ],
            ),

            //Google Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
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
                SizedBox(width: 20),
                Container(
                  padding: EdgeInsets.all(10),
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
    );
  }
}

import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton(
            onPressed: () {
              print("Redirecting to edit Wishlist page");
            },
            child: const Text("Edit"),
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Wishlists",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: 150.0,
                height: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: const Color.fromARGB(255, 223, 213, 213),
                    width: 2.0,
                  ),
                ),
              ),
              const Text(
                "Recently viewed",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Nothing added to the wishlist add to view",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromARGB(255, 92, 88, 88),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:airbnb_clone/models/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectionPage extends StatelessWidget {
  final Home home;
  const SelectionPage({super.key, required this.home});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.share),
          SizedBox(width: 10),
          Icon(Icons.favorite),
          SizedBox(width: 20),
        ],
      ),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: home.images.length,
                  itemBuilder: ((context, index) =>
                      Card(child: Image.network(home.images[index]))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 260),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ],
          ),
          Text(
            home.name,
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              home.description,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${home.rating}"),
                Text("${home.totalReviews} Reviews"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

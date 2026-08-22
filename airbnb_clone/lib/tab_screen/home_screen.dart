import 'package:airbnb_clone/main_screen/selection_page.dart';
import 'package:airbnb_clone/providers/home_provider.dart';
import 'package:airbnb_clone/sub_screen/profile_screen.dart';
import 'package:airbnb_clone/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).fetchHomes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: const CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(provider.errorMessage),
              ),
            );
          }
          if (provider.homes.isEmpty) {
            return const Center(child: Text("No Homes Found"));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular experiences in Guwahati",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_circle_right_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectionPage()),
                    );
                  },
                  child: Container(
                    height: 200,
                    child: ListView.separated(
                      padding: EdgeInsets.only(left: 15),
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.homes.length,
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeCard(home: provider.homes[index]),
                          Text(provider.homes[index].name),
                          Text(
                            "From ₹${(provider.homes[index].price).toString()}/night · ${provider.homes[index].rating}★",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 119, 119, 119),
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available next month in Noida",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_circle_right_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.homes.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeCard(home: provider.homes[index]),
                        Text(provider.homes[index].name),
                        Text(
                          "From ₹${(provider.homes[index].price).toString()}/night · ${provider.homes[index].rating}★",
                          style: TextStyle(
                            fontSize: 10,
                            color: const Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Stay in Jorhat",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_circle_right_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.homes.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeCard(home: provider.homes[index]),
                        Text(provider.homes[index].name),
                        Text(
                          "From ₹${(provider.homes[index].price).toString()}/night · ${provider.homes[index].rating}★",
                          style: TextStyle(
                            fontSize: 10,
                            color: const Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available next month in Noida",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_circle_right_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.homes.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeCard(home: provider.homes[index]),
                        Text(provider.homes[index].name),
                        Text(
                          "From ₹${(provider.homes[index].price).toString()}/night · ${provider.homes[index].rating}★",
                          style: TextStyle(
                            fontSize: 10,
                            color: const Color.fromARGB(255, 119, 119, 119),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

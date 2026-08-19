import 'package:airbnb_clone/providers/home_provider.dart';
import 'package:airbnb_clone/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
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
      appBar: AppBar(
        title: const Text("Explore Screen: Testing phase"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [],
      ),

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
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),

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
                Container(
                  height: 150,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.homes.length,
                    itemBuilder: (context, index) =>
                        HomeCard(home: provider.homes[index]),
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
                  height: 150,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.homes.length,
                    itemBuilder: (context, index) =>
                        HomeCard(home: provider.homes[index]),
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
                  height: 150,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.homes.length,
                    itemBuilder: (context, index) =>
                        HomeCard(home: provider.homes[index]),
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
                  height: 150,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.homes.length,
                    itemBuilder: (context, index) =>
                        HomeCard(home: provider.homes[index]),
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

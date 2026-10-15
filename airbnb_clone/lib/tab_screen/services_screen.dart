import 'package:airbnb_clone/main.dart';
import 'package:airbnb_clone/providers/service_provider.dart';
import 'package:airbnb_clone/widgets/service_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});
  @override
  State<ServicesScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ServiceProvider>(context, listen: false).fetchService();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ServiceProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(child: const CircularProgressIndicator());
          }
          if (provider.errorMessage.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsetsGeometry.all(8),
                child: Text(provider.errorMessage),
              ),
            );
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
                        "Services in Guwahati",
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

                ///the first list
                Container(
                  height: 230,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.services.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ServiceCard(service: provider.services[index]),
                          Text(provider.services[index].name),
                          Text(
                            provider.services[index].location,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkgrey,
                            ),
                          ),
                          Text(
                            "From ₹${(provider.services[index].price).toString()}/guest · ${provider.services[index].rating}★",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 119, 119, 119),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Services in Shillong",
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
                // the second list
                Container(
                  height: 230,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.services.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ServiceCard(service: provider.services[index]),
                          Text(provider.services[index].name),
                          Text(
                            provider.services[index].location,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkgrey,
                            ),
                          ),
                          Text(
                            "From ₹${(provider.services[index].price).toString()}/guest · ${provider.services[index].rating}★",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 119, 119, 119),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Services in Dispur",
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
                //the third list
                Container(
                  height: 230,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.services.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ServiceCard(service: provider.services[index]),
                          Text(provider.services[index].name),
                          Text(
                            provider.services[index].location,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkgrey,
                            ),
                          ),
                          Text(
                            "From ₹${(provider.services[index].price).toString()}/guest · ${provider.services[index].rating}★",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 119, 119, 119),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Services in Dimapur",
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
                  height: 230,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.services.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ServiceCard(service: provider.services[index]),
                          Text(provider.services[index].name),
                          Text(
                            provider.services[index].location,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkgrey,
                            ),
                          ),
                          Text(
                            "From ₹${(provider.services[index].price).toString()}/guest · ${provider.services[index].rating}★",
                            style: TextStyle(
                              fontSize: 10,
                              color: const Color.fromARGB(255, 119, 119, 119),
                            ),
                          ),
                        ],
                      ),
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

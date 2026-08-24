import 'package:airbnb_clone/main.dart';
import 'package:airbnb_clone/providers/experience_provider.dart';
import 'package:airbnb_clone/widgets/experience_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});
  @override
  State<ExperienceScreen> createState() => _ExperienceState();
}

class _ExperienceState extends State<ExperienceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExperienceProvider>(context, listen: false).fetchExperience();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ExperienceProvider>(
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
          if (provider.experience.isEmpty) {
            return const Center(child: Text("No Experience Found"));
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Airbnb Originals",
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Hosted by the world's most interesting people",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
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
                    itemCount: provider.experience.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExperienceCard(
                            experience: provider.experience[index],
                          ),
                          Text(provider.experience[index].name),
                          Text(
                            provider.experience[index].location,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkgrey,
                            ),
                          ),
                          Text(
                            "From ₹${(provider.experience[index].price).toString()}/night · ${provider.experience[index].rating}★",
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
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Popular with travellers from your area",
                    style: GoogleFonts.montserrat(fontSize: 28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Experiences in Guwahati",
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
                    itemCount: provider.experience.length,
                    itemBuilder: (context, index) => SizedBox(
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExperienceCard(
                            experience: provider.experience[index],
                          ),
                          Text(provider.experience[index].name),
                          Text(
                            provider.experience[index].location,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.darkgrey,
                            ),
                          ),
                          Text(
                            "From ₹${(provider.experience[index].price).toString()}/night · ${provider.experience[index].rating}★",
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
                        "Popular experiences in Kolkata",
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
                  height: 210,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.experience.length,
                    itemBuilder: (context, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExperienceCard(experience: provider.experience[index]),
                        Text(provider.experience[index].name),
                        Text(
                          provider.experience[index].location,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.darkgrey,
                          ),
                        ),
                        Text(
                          "From ₹${(provider.experience[index].price).toString()}/night · ${provider.experience[index].rating}★",
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

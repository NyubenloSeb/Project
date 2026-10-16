import 'package:airbnb_clone/main.dart';
import 'package:airbnb_clone/models/home.dart';
import 'package:airbnb_clone/sub_screen/review_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:readmore/readmore.dart';

class SelectionPage extends StatelessWidget {
  final Home home;
  const SelectionPage({super.key, required this.home});
  IconData getPerkIcon(String perk) {
    switch (perk) {
      case 'Free Wi-Fi':
      case 'High-Speed Wi-Fi':
        return Icons.wifi;

      case 'Mountain View':
        return Icons.landscape;

      case 'Free Parking':
      case 'Secure Parking':
        return Icons.local_parking;

      case 'Fully Equipped Kitchen':
      case 'Kitchen':
        return Icons.kitchen;

      case 'Private Balcony':
      case 'Private Terrace':
      case 'Private Veranda':
        return Icons.deck;

      case 'Heating':
        return Icons.thermostat;

      case 'Hot Water':
        return Icons.water_drop;

      case 'Air Conditioning':
        return Icons.ac_unit;

      case 'Dedicated Workspace':
        return Icons.work;

      case 'Family Friendly':
        return Icons.family_restroom;

      case 'Self Check-in':
        return Icons.key;

      case 'Garden':
      case 'Private Garden':
        return Icons.yard;

      case 'Peaceful Surroundings':
      case 'Scenic Surroundings':
        return Icons.nature;

      case 'Breakfast Available':
        return Icons.free_breakfast;

      case 'Home-Cooked Meals Available':
        return Icons.dinner_dining;

      case 'Private Bathroom':
        return Icons.bathroom;

      case 'Outdoor Seating':
        return Icons.chair;

      case 'Outdoor Dining':
        return Icons.outdoor_grill;

      case 'Pet Friendly':
        return Icons.pets;

      case 'Local Travel Assistance':
        return Icons.directions_car;

      case 'Local Travel Guidance':
      case 'Local Sightseeing Assistance':
        return Icons.map;

      case 'Local Food Recommendations':
      case 'Restaurants Nearby':
        return Icons.restaurant;

      case 'Boat Trip Assistance':
        return Icons.directions_boat;

      case 'Washing Machine':
        return Icons.local_laundry_service;

      case 'Smart TV':
        return Icons.tv;

      case 'Elevator':
        return Icons.elevator;

      case 'Beach Nearby':
        return Icons.beach_access;

      case 'Luggage Storage':
        return Icons.luggage;

      case 'Wooden Interiors':
        return Icons.cabin;

      case 'Complimentary Tea':
      case 'Tea and Coffee':
        return Icons.coffee;

      case 'Traditional Architecture':
        return Icons.account_balance;

      case 'Courtyard':
        return Icons.roofing;

      case 'Dining Area':
        return Icons.dining;

      case 'Daily Housekeeping':
        return Icons.cleaning_services;

      case 'Backwater Views':
        return Icons.water;

      case 'City View':
        return Icons.location_city;

      case 'Security':
        return Icons.security;

      default:
        return Icons.check_circle_outline;
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                home.description,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 15),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "${home.rating}",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Rating",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${home.totalReviews.toInt()}",
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Reviews",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.grey, indent: 30, endIndent: 30),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(home.photo),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hosted By ${home.hostName}",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("10 months hosting"),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.grey, indent: 30, endIndent: 30),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 10,
              ),
              child: ReadMoreText(
                home.propertyDescription,
                trimMode: TrimMode.Line,
                trimLines: 3,
                trimExpandedText: "Show less",
                trimCollapsedText: "Show more",
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ),
            Divider(color: Colors.grey, indent: 30, endIndent: 30),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "What this place offers",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            //perks
            PerksSection(perks: home.perks, getPerkIcon: getPerkIcon),
            SizedBox(height: 20),
            Divider(color: Colors.grey, indent: 30, endIndent: 30),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Where you'll be",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                home.location,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                height: 450,
                width: 320,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://img.magnific.com/premium-vector/city-map-town-streets-with-park-river-downtown-gps-navigation-plan-abstract-transportation-urban_163786-697.jpg",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Exact location will be provided after booking",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Divider(color: Colors.grey, indent: 30, endIndent: 30),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Guest reviews mention",
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.grey, width: 1),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.ac_unit),
                          Text(
                            "Air Condition",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "9",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10),
              ),
            ),
            SizedBox(height: 30),
            Divider(color: Colors.grey, indent: 30, endIndent: 30),
            SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 15),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) => Container(
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.grey, width: 1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=NHwxMjA3fDA%3D",
                            ),
                            radius: 25,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Varsha"),
                              Text("10 months on Airbnb"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Lorem Ipsum is simply dumranslatio only many decades, but also the leap into electronic typesetting, remaining essentially unchanged. It was ",
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 10),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  backgroundColor: AppColors.lightgrey,
                  fixedSize: Size(300, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Show all Reviews",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                "Meet your host",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 250,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      spreadRadius: -5,
                      offset: Offset(3, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(home.photo),
                            radius: 60,
                          ),
                          SizedBox(height: 10),
                          Text(
                            home.hostName,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${home.totalReviews.toInt()}",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          Text(
                            "Reviews",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(height: 1, width: 80, color: Colors.black),
                          Text(
                            "${home.rating}",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Rating",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(height: 1, width: 80, color: Colors.black),
                          Text(
                            "1",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Year Hosting",
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.cake_outlined, size: 22),
                  SizedBox(width: 10),
                  Text(
                    "Born in the 90s",
                    style: GoogleFonts.montserrat(fontSize: 18, height: 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.work_outline, size: 22),
                  SizedBox(width: 10),
                  Text(
                    "My work: HR Manager",
                    style: GoogleFonts.montserrat(fontSize: 18, height: 1),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Host Details",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Response rate: 100%",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "Response within an hour",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  backgroundColor: AppColors.lightgrey,
                  fixedSize: Size(300, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Message Host",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FaIcon(
                    FontAwesomeIcons.airbnb,
                    color: AppColors.accentRed,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 250,
                    child: Text(
                      "To help protect you payment, always use Airbnb to send money and communicate with host",
                      style: GoogleFonts.montserrat(fontSize: 12, height: 1),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: AppColors.grey, indent: 30, endIndent: 30),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Availability",
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "20-23 November",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(color: AppColors.grey, indent: 30, endIndent: 30),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Things to know",
                    style: GoogleFonts.montserrat(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.calendarXmark,
                        color: AppColors.accentRed,
                        size: 40,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cancellation Policy",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: 250,
                            child: Text(
                              "To help protect you payment, always use Airbnb to send money and communicate with host",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                height: 1,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.key,
                        color: AppColors.accentRed,
                        size: 40,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "House Rules",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: 250,
                            child: Text(
                              "To help protect you payment, always use Airbnb to send money and communicate with host",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                height: 1,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.shield,
                        color: AppColors.accentRed,
                        size: 40,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Safety & Property",
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: 250,
                            child: Text(
                              "To help protect you payment, always use Airbnb to send money and communicate with host",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                height: 1,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(color: AppColors.grey, indent: 30, endIndent: 30),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.exclamation,
                  color: AppColors.accentRed,
                  size: 20,
                ),
                SizedBox(width: 10),
                Text("Report this listing"),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 1, width: double.infinity, color: Colors.black),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "\$79",
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "For 2 nights: 28-30 Nov",
                        style: GoogleFonts.montserrat(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ReviewBookingScreen(home: home),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: AppColors.accentRed,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "Reserve",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class PerksSection extends StatefulWidget {
  final List<String> perks;
  final IconData Function(String) getPerkIcon;

  const PerksSection({
    super.key,
    required this.perks,
    required this.getPerkIcon,
  });

  @override
  State<PerksSection> createState() => _PerksSectionState();
}

class _PerksSectionState extends State<PerksSection> {
  bool showAllPerks = false;

  @override
  Widget build(BuildContext context) {
    final visiblePerks = showAllPerks
        ? widget.perks
        : widget.perks.take(4).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...visiblePerks.map((perk) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              children: [
                Icon(widget.getPerkIcon(perk), size: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    perk,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),

        if (widget.perks.length > 4)
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: AppColors.lightgrey,
                fixedSize: Size(300, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
              ),
              onPressed: () {
                setState(() {
                  showAllPerks = !showAllPerks;
                });
              },
              child: Text(
                showAllPerks
                    ? 'Show less'
                    : 'Show all ${widget.perks.length} amenities',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

import 'package:airbnb_clone/providers/home_provider.dart';
import 'package:airbnb_clone/tab_screen/experience_screen.dart';
import 'package:airbnb_clone/tab_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 160,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            children: [
              SizedBox(height: 70),
              Align(
                alignment: AlignmentGeometry.centerStart,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),

                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 50,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 5),
                        Text("Start your search"),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              const TabBar(
                dividerColor: Colors.transparent,
                indicatorColor: Colors.black,

                tabs: <Widget>[
                  Tab(text: "Homes", icon: Icon(Icons.home)),
                  Tab(text: "Experience", icon: Icon(Icons.explore)),
                  Tab(text: "Services", icon: Icon(Icons.room_service)),
                ],
              ),
            ],
          ),
        ),

        body: const TabBarView(
          children: <Widget>[
            HomeScreen(),
            ExperienceScreen(),
            Center(child: Text("Service")),
          ],
        ),
      ),
    );
  }
}

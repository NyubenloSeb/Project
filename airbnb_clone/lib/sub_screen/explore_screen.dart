import 'package:airbnb_clone/providers/home_provider.dart';
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
          automaticallyImplyLeading: false,
          actions: [
            Container(
              height: 20,
              decoration: BoxDecoration(color: Colors.amber),
            ),
          ],
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.black,

            tabs: <Widget>[
              Tab(text: "Homes", icon: Icon(Icons.home)),
              Tab(text: "Experience", icon: Icon(Icons.explore)),
              Tab(text: "Services", icon: Icon(Icons.room_service)),
            ],
          ),
        ),

        body: const TabBarView(
          children: <Widget>[
            HomeScreen(),
            Center(child: Text("Experince")),
            Center(child: Text("Service")),
          ],
        ),
      ),
    );
  }
}

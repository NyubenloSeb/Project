import 'package:airbnb_clone/sub_screen/explore_screen.dart';
import 'package:airbnb_clone/sub_screen/message_screen.dart';
import 'package:airbnb_clone/sub_screen/profile_screen.dart';
import 'package:airbnb_clone/sub_screen/trip_screen.dart';
import 'package:airbnb_clone/sub_screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final String? userName;

  const HomePage({super.key, this.userName});

  @override
  State<HomePage> createState() => _homestate();
}

class _homestate extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> get _pageSelected => [
    ExploreScreen(),
    WishlistScreen(),
    TripScreen(),
    MessageScreen(),
    ProfileScreen(userName: widget.userName),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pageSelected.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.airbnb),
            label: "Trips",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: "Messages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

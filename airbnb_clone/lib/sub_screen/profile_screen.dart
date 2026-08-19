import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(20),
        actions: [Icon(Icons.notifications)],
        toolbarHeight: 100,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 31),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              //The profile box
              child: Container(
                margin: EdgeInsets.all(20),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(128),
                      spreadRadius: 2,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 10),
                        height: 85,

                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 187, 209),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "N",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.pink,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Name",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text("Guest", style: TextStyle(fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  //first Container
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(128),
                          spreadRadius: 2,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 10),
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://static.vecteezy.com/system/resources/thumbnails/000/134/196/small/world-travel-free-vector.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Past trips",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  //second container
                  child: Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(128),
                          spreadRadius: 2,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20, bottom: 10),
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    "https://www.freevector.com/uploads/vector/preview/28523/Group-of-People.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Connections",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                margin: EdgeInsets.all(20),
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(
                        128,
                      ), // Shadow color with transparency
                      spreadRadius: 2, // How wide the shadow extends
                      blurRadius: 7, // How soft/fuzzy the shadow edges look
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://img.magnific.com/free-vector/professional-business-woman-posing-with-folded-hands_10045-815.jpg?semt=ais_test_b&w=740&q=80",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 35),
                          Text(
                            "Become a host",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              "It's easy to start hosting and earn extra income",
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //List of buttons for the menu
            ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
              title: Text("Account Settings"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.settings_outlined),
              onTap: () => {print("Hello")},
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
              title: Text("Get help"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.question_mark),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
              title: Text("View Profile"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.account_circle_outlined),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
              title: Text("Privacy"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.back_hand_outlined),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: const Color.fromARGB(255, 214, 214, 214),
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
              title: Text("Refer a host"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.people_outline),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
              title: Text("Find a co-host"),
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.person),
            ),
            ListTile(
              contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10),
              title: Text("Logout"),
              leading: Icon(Icons.door_back_door_outlined),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

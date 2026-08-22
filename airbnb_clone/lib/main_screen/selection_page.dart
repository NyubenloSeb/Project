import 'package:flutter/material.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});
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
      body: Center(child: Text("data")),
    );
  }
}

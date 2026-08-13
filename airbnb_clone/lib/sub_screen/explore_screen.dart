import 'package:airbnb_clone/providers/home_provider.dart';
import 'package:airbnb_clone/widgets/home_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Screen: Testing phase"),
        centerTitle: true,
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
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // columns in grid
                childAspectRatio:
                    0.7, // width to height ratio of each grid item
                crossAxisSpacing: 10, // horizontal spacing
                mainAxisSpacing: 10, // vertical spacing
              ),
              itemCount: provider.homes.length,
              itemBuilder: (context, index) =>
                  HomeCard(home: provider.homes[index]),
            ),
          );
        },
      ),
    );
  }
}

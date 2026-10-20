import 'package:airbnb_clone/main_screen/selection_page.dart';
import 'package:airbnb_clone/models/home.dart';
import 'package:airbnb_clone/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeCard extends StatelessWidget {
  final Home home;

  const HomeCard({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final isFavorite = wishlistProvider.isWishlisted(home);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SelectionPage(home: home)),
            );
          },
          child: SizedBox(
            height: 150,
            width: 150,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    home.images.isNotEmpty ? home.images[0] : '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Center(child: Icon(Icons.image_not_supported)),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: IconButton(
                      onPressed: () async {
                        final success = await context
                            .read<WishlistProvider>()
                            .toggleWishlist(home);

                        if (!context.mounted) return;

                        if (!success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.read<WishlistProvider>().errorMessage,
                              ),
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

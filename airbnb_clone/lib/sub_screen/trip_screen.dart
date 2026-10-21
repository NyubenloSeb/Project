import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:airbnb_clone/util/constants.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  final storage = const FlutterSecureStorage();

  List<dynamic> bookings = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      final token = await storage.read(key: 'jwt_token');

      if (token == null) {
        setState(() {
          error = 'Please log in to view your trips.';
          loading = false;
        });
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/bookings'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          bookings = data['bookings'] ?? [];
          loading = false;
        });
      } else {
        setState(() {
          error = 'Could not load your trips.';
          loading = false;
        });
      }
    } catch (_) {
      setState(() {
        error = 'Unable to connect to the server.';
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              const Text(
                'Trips',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : error != null
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(error!),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  loading = true;
                                  error = null;
                                });
                                fetchBookings();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : bookings.isEmpty
                    ? _emptyTrips()
                    : RefreshIndicator(
                        onRefresh: fetchBookings,
                        child: ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            final booking = bookings[index];
                            final checkIn = DateTime.tryParse(
                              booking['checkIn'] ?? '',
                            );
                            final checkOut = DateTime.tryParse(
                              booking['checkOut'] ?? '',
                            );

                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: ListTile(
                                title: Text(
                                  '${booking['listingType'] ?? 'Booking'}'
                                      .toUpperCase(),
                                ),
                                subtitle: Text(
                                  'Check-in: ${checkIn == null ? 'N/A' : checkIn.toLocal().toString().split(' ')[0]}\n'
                                  'Check-out: ${checkOut == null ? 'N/A' : checkOut.toLocal().toString().split(' ')[0]}\n'
                                  'Guests: ${booking['guests'] ?? 1}\n'
                                  'Status: ${booking['status'] ?? 'pending'}',
                                ),
                                trailing: Text(
                                  '£${booking['totalPrice'] ?? 0}',
                                ),
                                isThreeLine: true,
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyTrips() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://i.pinimg.com/736x/8c/11/4e/8c114ef2759b895083f4cd2886deb57f.jpg',
            height: 200,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.luggage_outlined, size: 100),
          ),
          const Text(
            'Build the perfect trip',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Explore homes, experiences and services.\n'
            'When you book, your reservation will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600, height: 1.4),
          ),
        ],
      ),
    );
  }
}

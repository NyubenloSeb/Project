import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:airbnb_clone/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:airbnb_clone/models/home.dart';
import 'package:airbnb_clone/sub_screen/reservation_confirmed_screen.dart';

class ConfirmAndPayScreen extends StatelessWidget {
  final Home home;
  final DateTimeRange dates;
  final int guests;
  final double totalPrice;
  final String paymentMethod;
  final String currency;

  const ConfirmAndPayScreen({
    super.key,
    required this.home,
    required this.dates,
    required this.guests,
    required this.totalPrice,
    required this.paymentMethod,
    required this.currency,
  });

  static const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String formatDate(DateTime date) =>
      '${date.day} ${months[date.month - 1]} ${date.year}';

  Widget detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget priceRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createBooking(BuildContext context) async {
    if (home.id == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Property ID is missing.')));
      return;
    }

    try {
      const storage = FlutterSecureStorage();
      final token = await storage.read(key: 'jwt_token');

      if (token == null) {
        throw Exception('Please log in again.');
      }

      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'homeId': home.id,
          'checkIn': dates.start.toIso8601String(),
          'checkOut': dates.end.toIso8601String(),
          'guests': guests,
        }),
      );

      if (!context.mounted) return;

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking created successfully.')),
        );

        Navigator.popUntil(context, (route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message'] ?? 'Unable to create booking.'),
          ),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final nights = dates.end.difference(dates.start).inDays;
    final nightlyPrice = nights > 0 ? totalPrice / nights : totalPrice;
    final symbol = '₹';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 30),
                      ),
                      const Expanded(
                        child: Text(
                          'Confirm and pay',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        ),
                        icon: const Icon(Icons.close, size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD8D8D8)),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: home.images.isNotEmpty
                                  ? Image.network(
                                      home.images.first,
                                      width: 110,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const SizedBox(
                                            width: 110,
                                            height: 120,
                                            child: Icon(Icons.house, size: 40),
                                          ),
                                    )
                                  : const SizedBox(
                                      width: 110,
                                      height: 120,
                                      child: Icon(Icons.house, size: 40),
                                    ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    home.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('★ ${home.rating}  ♡ Guest favourite'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        detail(
                          'Dates',
                          '${formatDate(dates.start)} – ${formatDate(dates.end)}',
                        ),
                        const Divider(),
                        detail(
                          'Guests',
                          '$guests ${guests == 1 ? 'adult' : 'adults'}',
                        ),
                        const Divider(),
                        detail(
                          'Total Price',
                          '$symbol${totalPrice.toStringAsFixed(2)} including taxes',
                        ),
                        const Divider(),
                        const SizedBox(height: 16),
                        const Text(
                          'Free cancellation',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Cancellation terms depend on the property.',
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Full policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD8D8D8)),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Payment method',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            const Icon(Icons.payment, size: 28),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                paymentMethod,
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const Icon(Icons.chevron_right, size: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 18),
                  const Text(
                    'Price Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  priceRow(
                    '$nights nights × $symbol${nightlyPrice.toStringAsFixed(2)}',
                    '$symbol${totalPrice.toStringAsFixed(2)}',
                  ),
                  priceRow('Taxes', '$symbol${0.toStringAsFixed(2)}'),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  priceRow(
                    'Total $currency',
                    '$symbol${totalPrice.toStringAsFixed(2)}',
                    bold: true,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Price breakdown',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFD8D8D8))),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () => createBooking(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF111111),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: Text(
                        paymentMethod,
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'By selecting the button, I agree to the booking terms.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

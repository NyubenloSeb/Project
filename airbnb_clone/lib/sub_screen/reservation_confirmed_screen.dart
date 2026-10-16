import 'package:flutter/material.dart';
import 'package:airbnb_clone/models/home.dart';

class ReservationConfirmedScreen extends StatelessWidget {
  final Home home;
  final DateTimeRange dates;
  final int guests;
  final double totalPrice;
  final String currency;

  const ReservationConfirmedScreen({
    super.key,
    required this.home,
    required this.dates,
    required this.guests,
    required this.totalPrice,
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

  @override
  Widget build(BuildContext context) {
    final nights = dates.end.difference(dates.start).inDays;
    final symbol = currency == 'GBP'
        ? '£'
        : currency == 'INR'
        ? '₹'
        : currency == 'EUR'
        ? '€'
        : '\$';

    final taxes = totalPrice * 0.043;
    final stayPrice = totalPrice - taxes;

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, size: 30),
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
                  const SizedBox(height: 40),

                  const Text(
                    'Your reservation is confirmed!',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30),

                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD8D8D8)),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: home.images.isNotEmpty
                                  ? Image.network(
                                      home.images.first,
                                      width: 115,
                                      height: 125,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const SizedBox(
                                            width: 115,
                                            height: 125,
                                            child: Icon(Icons.house, size: 40),
                                          ),
                                    )
                                  : const SizedBox(
                                      width: 115,
                                      height: 125,
                                      child: Icon(Icons.house, size: 40),
                                    ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    home.name,
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '★ ${home.rating}  ♡ Guest favourite',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),
                        const Divider(),

                        _detail(
                          'Dates',
                          '${formatDate(dates.start)} – ${formatDate(dates.end)}',
                        ),
                        const Divider(),

                        _detail(
                          'Guests',
                          '$guests ${guests == 1 ? 'adult' : 'adults'}',
                        ),
                        const Divider(),

                        const SizedBox(height: 20),
                        const Text(
                          'Free cancellation',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Cancellation terms depend on the property.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Full policy',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 34),
                  const Text(
                    'Price Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 18),

                  _priceRow(
                    '$nights nights × $symbol${(stayPrice / (nights > 0 ? nights : 1)).toStringAsFixed(2)}',
                    '$symbol${stayPrice.toStringAsFixed(2)}',
                  ),
                  _priceRow('Taxes', '$symbol${taxes.toStringAsFixed(2)}'),

                  const SizedBox(height: 28),
                  const Divider(),
                  const SizedBox(height: 18),

                  _priceRow(
                    'Total $currency',
                    '$symbol${totalPrice.toStringAsFixed(2)}',
                    bold: true,
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFD8D8D8))),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD0446B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Return to Explore Page',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
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
}

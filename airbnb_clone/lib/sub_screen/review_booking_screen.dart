import 'package:flutter/material.dart';
import 'package:airbnb_clone/models/home.dart';
import 'package:airbnb_clone/sub_screen/payment_method_screen.dart';

class ReviewBookingScreen extends StatefulWidget {
  final Home home;

  const ReviewBookingScreen({super.key, required this.home});

  @override
  State<ReviewBookingScreen> createState() => _ReviewBookingScreenState();
}

class _ReviewBookingScreenState extends State<ReviewBookingScreen> {
  late DateTimeRange dates;
  int guests = 1;
  final double totalPrice = 89.23;

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
  void initState() {
    super.initState();
    final now = DateTime.now();
    dates = DateTimeRange(
      start: DateTime(
        now.year,
        now.month,
        now.day,
      ).add(const Duration(days: 1)),
      end: DateTime(now.year, now.month, now.day).add(const Duration(days: 3)),
    );
  }

  Future<void> changeDates() async {
    final selected = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: dates,
    );
    if (selected != null) setState(() => dates = selected);
  }

  Future<void> changeGuests() async {
    int selected = guests;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Guests'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Adults'),
              IconButton(
                onPressed: selected > 1
                    ? () => setDialogState(() => selected--)
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text('$selected'),
              IconButton(
                onPressed: () => setDialogState(() => selected++),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() => guests = selected);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailRow(String title, String value, VoidCallback onChange) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          SizedBox(
            width: 120,
            height: 54,
            child: ElevatedButton(
              onPressed: onChange,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD9D9D9),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Change'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final home = widget.home;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, size: 30),
                    ),
                  ),
                  const Text(
                    'Review and continue',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                        detailRow(
                          'Dates',
                          '${formatDate(dates.start)} – ${formatDate(dates.end)}',
                          changeDates,
                        ),
                        const Divider(),
                        detailRow(
                          'Guests',
                          '$guests ${guests == 1 ? 'adult' : 'adults'}',
                          changeGuests,
                        ),
                        const Divider(),
                        detailRow(
                          'Total Price',
                          '\$${totalPrice.toStringAsFixed(2)} including taxes',
                          () => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Price is currently a placeholder.',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 16),
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
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: Container(height: 4, color: Colors.black)),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(height: 4, color: Colors.grey.shade300),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Container(height: 4, color: Colors.grey.shade300),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentMethodScreen(
                          home: home,
                          dates: dates,
                          guests: guests,
                          totalPrice: totalPrice,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF111111),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 22)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

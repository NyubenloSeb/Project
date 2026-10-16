import 'package:flutter/material.dart';
import 'package:airbnb_clone/models/home.dart';
import 'package:airbnb_clone/sub_screen/confirm_and_pay_screen.dart';

class PaymentMethodScreen extends StatefulWidget {
  final Home home;
  final DateTimeRange dates;
  final int guests;
  final double totalPrice;

  const PaymentMethodScreen({
    super.key,
    required this.home,
    required this.dates,
    required this.guests,
    required this.totalPrice,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = 'Credit or debit card';
  String currency = 'GBP';

  final methods = ['Credit or debit card', 'PayPal', 'Google Pay'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
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
                  const SizedBox(height: 24),
                  const Text(
                    'Add a payment method',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Add a payment method for $currency.',
                    style: const TextStyle(fontSize: 20),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final result = await showDialog<String>(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: const Text('Switch currency'),
                          children: ['GBP', 'INR', 'USD', 'EUR']
                              .map(
                                (value) => SimpleDialogOption(
                                  onPressed: () =>
                                      Navigator.pop(context, value),
                                  child: Text(value),
                                ),
                              )
                              .toList(),
                        ),
                      );
                      if (result != null) {
                        setState(() => currency = result);
                      }
                    },
                    child: const Text(
                      'Switch Currency',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 44),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFD8D8D8)),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Column(
                      children: [
                        for (int i = 0; i < methods.length; i++) ...[
                          InkWell(
                            onTap: () =>
                                setState(() => selectedMethod = methods[i]),
                            child: SizedBox(
                              height: 110,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 80,
                                    child: Center(
                                      child: i == 0
                                          ? const Icon(
                                              Icons.credit_card,
                                              size: 38,
                                            )
                                          : i == 1
                                          ? const Text(
                                              'P',
                                              style: TextStyle(
                                                color: Color(0xFF253B80),
                                                fontSize: 42,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            )
                                          : const Text.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'G',
                                                    style: TextStyle(
                                                      color: Color(0xFF4285F4),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' Pay',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: TextStyle(fontSize: 22),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                  Expanded(
                                    child: Text(
                                      methods[i],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    selectedMethod == methods[i]
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (i != methods.length - 1) const Divider(height: 1),
                        ],
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
                Expanded(child: Container(height: 4, color: Colors.black)),
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
                        builder: (_) => ConfirmAndPayScreen(
                          home: widget.home,
                          dates: widget.dates,
                          guests: widget.guests,
                          totalPrice: widget.totalPrice,
                          paymentMethod: selectedMethod,
                          currency: currency,
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

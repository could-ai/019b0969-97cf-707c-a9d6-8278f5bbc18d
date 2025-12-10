import 'package:flutter/material.dart';
import '../../models/bill.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = ModalRoute.of(context)!.settings.arguments as Bill;
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Bill')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Pay $
	{bill.amount} for {bill.title}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mock payment integration
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment successful')));
                Navigator.pop(context);
              },
              child: const Text('Confirm Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
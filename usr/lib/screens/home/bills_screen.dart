import 'package:flutter/material.dart';
import '../../models/bill.dart';
import '../../services/api_service.dart';

class BillsScreen extends StatefulWidget {
  const BillsScreen({super.key});

  @override
  State<BillsScreen> createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  List<Bill> _bills = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBills();
  }

  Future<void> _loadBills() async {
    final bills = await ApiService.fetchBills();
    setState(() {
      _bills = bills;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bills')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _bills.length,
              itemBuilder: (context, index) {
                final bill = _bills[index];
                return ListTile(
                  title: Text(bill.title),
                  subtitle: Text('Due: 
	t{bill.dueDate} - $
	{bill.amount}'),
                  trailing: ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/payments', arguments: bill),
                    child: const Text('Pay'),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBillDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddBillDialog() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Bill'),
        content: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: amountController, decoration: const InputDecoration(labelText: 'Amount'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () async {
            final bill = Bill(id: DateTime.now().toString(), title: titleController.text, amount: double.parse(amountController.text), dueDate: DateTime.now().add(const Duration(days: 7)), status: 'Pending');
            await ApiService.addBill(bill);
            _loadBills();
            Navigator.pop(context);
          }, child: const Text('Add')),
        ],
      ),
    );
  }
}
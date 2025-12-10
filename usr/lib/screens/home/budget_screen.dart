import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/budget.dart';
import '../../services/api_service.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  List<Budget> _budgets = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBudgets();
  }

  Future<void> _loadBudgets() async {
    final budgets = await ApiService.fetchBudgets();
    setState(() {
      _budgets = budgets;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: _budgets.map((b) => PieChartSectionData(
                        value: b.spent,
                        title: b.category,
                        color: Colors.primaries[_budgets.indexOf(b) % Colors.primaries.length],
                      )).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _budgets.length,
                    itemBuilder: (context, index) {
                      final budget = _budgets[index];
                      return ListTile(
                        title: Text(budget.category),
                        subtitle: Text('Spent: $
	{budget.spent} / Limit: $
	{budget.limit}'),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddBudgetDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddBudgetDialog() {
    final categoryController = TextEditingController();
    final limitController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Budget'),
        content: Column(
          children: [
            TextField(controller: categoryController, decoration: const InputDecoration(labelText: 'Category')),
            TextField(controller: limitController, decoration: const InputDecoration(labelText: 'Limit'), keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () async {
            final budget = Budget(id: DateTime.now().toString(), category: categoryController.text, limit: double.parse(limitController.text), spent: 0.0);
            await ApiService.addBudget(budget);
            _loadBudgets();
            Navigator.pop(context);
          }, child: const Text('Add')),
        ],
      ),
    );
  }
}
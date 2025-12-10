import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../services/api_service.dart';
import '../../models/bill.dart';
import '../../models/budget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _totalBills = 0;
  double _totalBudget = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final bills = await ApiService.fetchBills();
    final budgets = await ApiService.fetchBudgets();
    setState(() {
      _totalBills = bills.fold(0, (sum, bill) => sum + bill.amount);
      _totalBudget = budgets.fold(0, (sum, budget) => sum + budget.limit);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Total Bills'),
                      subtitle: Text('$
	{_totalBills}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Total Budget'),
                      subtitle: Text('$
	{_totalBudget}'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: [FlSpot(0, _totalBills), FlSpot(1, _totalBudget)],
                            isCurved: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
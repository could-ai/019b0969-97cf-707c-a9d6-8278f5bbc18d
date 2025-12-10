import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bill.dart';
import '../models/budget.dart';

class ApiService {
  static const String baseUrl = 'https://your-supabase-url.supabase.co'; // Replace with actual

  // Mocked API calls - replace with real Supabase/Edge Function calls
  static Future<List<Bill>> fetchBills() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Bill(id: '1', title: 'Electricity', amount: 100.0, dueDate: DateTime.now().add(const Duration(days: 5)), status: 'Pending'),
      Bill(id: '2', title: 'Internet', amount: 50.0, dueDate: DateTime.now().add(const Duration(days: 10)), status: 'Paid'),
    ];
  }

  static Future<void> addBill(Bill bill) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock add
  }

  static Future<List<Budget>> fetchBudgets() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Budget(id: '1', category: 'Food', limit: 300.0, spent: 150.0),
      Budget(id: '2', category: 'Transport', limit: 200.0, spent: 100.0),
    ];
  }

  static Future<void> addBudget(Budget budget) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock add
  }
}
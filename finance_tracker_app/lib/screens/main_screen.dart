import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_list.dart';
import '../widgets/add_expense_modal.dart';
import '../widgets/expense_chart.dart'; // Import the ExpenseChart widget

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _startAddNewExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddExpenseModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewExpense(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Total Spending: \$${expenseProvider.totalSpending.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          ExpenseChart(), // Add the ExpenseChart widget here
          Expanded(
            child: ExpenseList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewExpense(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../models/expense.dart';
import '../widgets/add_expense_modal.dart'; // Import AddExpenseModal

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final expenses = expenseProvider.expenses;

    return expenses.isEmpty
        ? const Center(
            child: Text(
              'No expenses added yet!',
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (ctx, index) {
              final expense = expenses[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${expense.amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    expense.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${expense.category} - ${DateFormat.yMMMd().format(expense.date)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                        onPressed: () => _startEditExpense(context, expense),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () =>
                            expenseProvider.removeExpense(expense.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  void _startEditExpense(BuildContext context, Expense expense) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddExpenseModal(
          isEditing: true,
          expense: expense,
        );
      },
    );
  }
}

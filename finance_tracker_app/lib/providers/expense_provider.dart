import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  double get totalSpending {
    return _expenses.fold(0, (sum, item) => sum + item.amount);
  }

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }

  Map<String, double> getCategoryTotals() {
    Map<String, double> categoryTotals = {};
    for (var expense in _expenses) {
      if (categoryTotals.containsKey(expense.category)) {
        categoryTotals[expense.category] =
            categoryTotals[expense.category]! + expense.amount;
      } else {
        categoryTotals[expense.category] = expense.amount;
      }
    }
    return categoryTotals;
  }

  void updateExpense(String id, Expense newExpense) {
    final expenseIndex = _expenses.indexWhere((expense) => expense.id == id);
    if (expenseIndex >= 0) {
      _expenses[expenseIndex] = newExpense;
      notifyListeners();
    }
  }
}

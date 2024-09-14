import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);
    final categoryTotals = expenseProvider.getCategoryTotals();

    List<PieChartSectionData> getSections() {
      final List<PieChartSectionData> sections = [];
      final total = categoryTotals.values.fold(0.0, (sum, item) => sum + item);

      categoryTotals.forEach((category, amount) {
        final double percentage = (amount / total) * 100;
        sections.add(
          PieChartSectionData(
            color: _getCategoryColor(category),
            value: amount,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      });

      return sections;
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Expenses by Category',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            categoryTotals.isEmpty
                ? const Text('No expenses to display.')
                : SizedBox(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: getSections(),
                        centerSpaceRadius: 40,
                        sectionsSpace: 2,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Food':
        return Colors.blue;
      case 'Transport':
        return Colors.green;
      case 'Shopping':
        return Colors.red;
      case 'Bills':
        return Colors.orange;
      case 'Entertainment':
        return Colors.purple;
      case 'Others':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}

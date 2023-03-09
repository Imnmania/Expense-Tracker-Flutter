import 'package:expense_tracker/features/expense_tracker/presentation/widgets/bar_graph/my_bar_chart.dart';
import 'package:flutter/material.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: MyBarChart(
        maxY: 100,
        sunAmount: 20,
        monAmount: 50,
        tueAmount: 10,
        wedAmount: 30,
        thuAmount: 24,
        friAmount: 3,
        satAmount: 90,
      ),
    );
  }
}

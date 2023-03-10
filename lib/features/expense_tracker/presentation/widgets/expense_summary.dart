import 'package:expense_tracker/core/datetime/datetime_helper.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/widgets/bar_graph/my_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/expense_bloc/expense_bloc.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({
    super.key,
    required this.startOfWeek,
  });

  @override
  Widget build(BuildContext context) {
    // get yyyymmdd for each day of this week
    String sunday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 0),
      ),
    );
    String monday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 1),
      ),
    );
    String tuesday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 2),
      ),
    );
    String wednesday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 3),
      ),
    );
    String thursday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 4),
      ),
    );
    String friday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 5),
      ),
    );
    String saturday = convertDateTimeToString(
      startOfWeek.add(
        const Duration(days: 6),
      ),
    );
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        if (state is ExpenseLoadedState) {
          return SizedBox(
            height: 200,
            child: MyBarChart(
              maxY: 100,
              sunAmount: state.dailyExpenseSummary[sunday] ?? 0,
              monAmount: state.dailyExpenseSummary[monday] ?? 0,
              tueAmount: state.dailyExpenseSummary[tuesday] ?? 0,
              wedAmount: state.dailyExpenseSummary[wednesday] ?? 0,
              thuAmount: state.dailyExpenseSummary[thursday] ?? 0,
              friAmount: state.dailyExpenseSummary[friday] ?? 0,
              satAmount: state.dailyExpenseSummary[saturday] ?? 0,
            ),
          );
        }
        return const Center(
          child: Text('Not loaded...'),
        );
      },
    );
  }
}

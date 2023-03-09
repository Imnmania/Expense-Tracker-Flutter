import 'package:expense_tracker/features/expense_tracker/data/model/expense_item.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/blocs/expense_bloc/expense_bloc.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/widgets/expense_summary.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/widgets/expense_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/add_expense_dialog.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => ExpenseScreenState();
}

class ExpenseScreenState extends State<ExpenseScreen> {
  late final TextEditingController expenseName;
  late final TextEditingController expenseAmount;

  @override
  void initState() {
    expenseName = TextEditingController();
    expenseAmount = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    expenseName.dispose();
    expenseAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ExpenseBloc, ExpenseState>(
        listener: (context, state) {
          if (state is ExpenseLoadingState) {
            debugPrint('Loading...');
          }
          if (state is ExpenseLoadedState) {
            debugPrint('Loaded...');
          }
          if (state is ExpenseLoadFailedState) {
            debugPrint(state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is ExpenseLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ExpenseLoadedState) {
            return ListView(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                ),
                // weekly summary
                ExpenseSummary(startOfWeek: state.startOfWeekDate),

                // list of expenses
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.expenseList.length,
                  itemBuilder: (context, index) {
                    final item = state.expenseList[index];
                    return ExpenseTile(
                      name: item.name,
                      amount: item.amount,
                      date: item.dateTime,
                    );
                  },
                ),
              ],
            );
          }
          if (state is ExpenseLoadFailedState) {
            return const Text('Failed to load expense list...');
          }
          return const Center(
            child: Text('No expense items found...'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final value = await showAddNewDialog(
            context,
            expenseNameController: expenseName,
            expenseAmountController: expenseAmount,
          );
          if (value && context.mounted) {
            BlocProvider.of<ExpenseBloc>(context).add(
              AddExpenseEvent(
                expenseItem: ExpenseItem(
                  name: expenseName.text,
                  amount: expenseAmount.text,
                  dateTime: DateTime.now(),
                ),
              ),
            );
            expenseName.clear();
            expenseAmount.clear();
          }
        },
      ),
    );
  }
}

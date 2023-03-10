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
  final _formKey = GlobalKey<FormState>();

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
                const SizedBox(height: 20),
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
            return const Center(
              child: Text('Failed to load expense list...'),
            );
          }
          return const Center(
            child: Text('No expense items found...'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade800,
        child: const Icon(
          Icons.add,
          color: Colors.white70,
        ),
        onPressed: () async {
          final value = await showAddNewDialog(
            context,
            expenseNameController: expenseName,
            expenseAmountController: expenseAmount,
            formKey: _formKey,
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

import 'package:expense_tracker/features/expense_tracker/data/repositories/expense_repository_impl.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/blocs/expense_bloc/expense_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/expense_tracker/presentation/screens/expense_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ExpenseBloc(
            expenseRepository: ExpenseRepositoryImpl(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[300],
          primarySwatch: Colors.cyan,
          useMaterial3: true,
        ),
        home: const ExpenseScreen(),
      ),
    );
  }
}

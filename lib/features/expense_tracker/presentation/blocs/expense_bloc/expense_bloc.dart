// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:equatable/equatable.dart';
import 'package:expense_tracker/features/expense_tracker/data/model/expense_item.dart';
import 'package:expense_tracker/features/expense_tracker/domain/repositories/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;
  ExpenseBloc({
    required this.expenseRepository,
  }) : super(const ExpenseInitial()) {
    on<LoadExpenseEvent>((event, emit) {
      emit(const ExpenseLoadingState());
      _loadAndEmitData();
    });
    on<AddExpenseEvent>((event, emit) {
      emit(const ExpenseLoadingState());
      expenseRepository.addNewExpense(event.expenseItem);
      _loadAndEmitData();
    });
    on<DeleteExpenseEvent>((event, emit) {
      emit(const ExpenseLoadingState());
      expenseRepository.deleteExpense(event.expenseItem);
      _loadAndEmitData();
    });
  }

  void _loadAndEmitData() {
    try {
      emit(
        ExpenseLoadedState(
          expenseList: expenseRepository.getAllExpenseList(),
          startOfWeekDate: expenseRepository.startOfWeekDate(),
        ),
      );
    } catch (ex) {
      emit(
        ExpenseLoadFailedState(
          errorMessage: ex.toString(),
        ),
      );
    }
  }
}

part of 'expense_bloc.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

/// state when initial
class ExpenseInitial extends ExpenseState {
  const ExpenseInitial();
}

/// state when loading happens
class ExpenseLoadingState extends ExpenseState {
  const ExpenseLoadingState();
}

/// state when loading success
class ExpenseLoadedState extends ExpenseState {
  final List<ExpenseItem> expenseList;
  final DateTime startOfWeekDate;

  const ExpenseLoadedState({
    required this.expenseList,
    required this.startOfWeekDate,
  });

  ExpenseLoadedState copyWith({
    List<ExpenseItem>? expenseList,
    DateTime? startOfWeekDate,
  }) {
    return ExpenseLoadedState(
      expenseList: expenseList ?? this.expenseList,
      startOfWeekDate: startOfWeekDate ?? this.startOfWeekDate,
    );
  }

  @override
  List<Object> get props => [expenseList];
}

/// state when loading fails
class ExpenseLoadFailedState extends ExpenseState {
  final String errorMessage;

  const ExpenseLoadFailedState({
    required this.errorMessage,
  });

  ExpenseLoadFailedState copyWith({
    String? errorMessage,
  }) {
    return ExpenseLoadFailedState(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [errorMessage];
}

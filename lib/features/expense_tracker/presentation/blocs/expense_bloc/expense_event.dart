part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class LoadExpenseEvent extends ExpenseEvent {
  const LoadExpenseEvent();
}

class AddExpenseEvent extends ExpenseEvent {
  final ExpenseItem expenseItem;

  const AddExpenseEvent({
    required this.expenseItem,
  });

  @override
  List<Object> get props => [expenseItem];
}

class DeleteExpenseEvent extends ExpenseEvent {
  final ExpenseItem expenseItem;

  const DeleteExpenseEvent({
    required this.expenseItem,
  });

  @override
  List<Object> get props => [expenseItem];
}

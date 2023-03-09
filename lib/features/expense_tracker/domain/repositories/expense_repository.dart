import '../../data/model/expense_item.dart';

abstract class ExpenseRepository {
  /// list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  /// get expense list
  List<ExpenseItem> getAllExpenseList();

  /// add new expense
  void addNewExpense(ExpenseItem expenseItem);

  /// delete expense
  void deleteExpense(ExpenseItem expenseItem);

  /// get weekday (mon, tues, etc) from a datetime object
  String getDayName(DateTime dateTime);

  /// get the date for start of the week (sunday)
  DateTime startOfWeekDate();

  /**
   * convert overall list of expenses into a daily expense summary
   * 
   * overallExpenseList = 
   * [
   *    [food, 2023/01/30, $10],
   *    [hat, 2023/01/31, $10],
   *    [drinks, 2023/02/01, $10],
   *    [food, 2023/02/02, $10],
   *    [food, 2023/02/03, $10],
   *    [food, 2023/02/04, $10],
   * ]
   * 
   * dailyExpenseSummary = 
   * [
   *    [2023/01/30: $25],
   *    [2023/01/31: $1],
   *    .
   *    .
   *    .
   * ]
   */ ///

  Map<String, double> calculateDailyExpenseSummary();
}

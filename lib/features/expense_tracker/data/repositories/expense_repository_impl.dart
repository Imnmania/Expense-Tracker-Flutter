import '../../../../core/datetime/datetime_helper.dart';
import '../model/expense_item.dart';
import '../../domain/repositories/expense_repository.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  @override
  List<ExpenseItem> overallExpenseList = [];

  @override
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  @override
  void addNewExpense(ExpenseItem expenseItem) {
    overallExpenseList.add(expenseItem);
  }

  @override
  void deleteExpense(ExpenseItem expenseItem) {
    overallExpenseList.remove(expenseItem);
  }

  @override
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  @override
  DateTime startOfWeekDate() {
    DateTime? startOfWeek;

    // get todays date
    DateTime today = DateTime.now();

    // go backwards from today to find sunday
    for (var i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  @override
  Map<String, double> calculateDailyExpenseSummary() {
    /// date (yyyymmdd) : amountTotalForDay
    Map<String, double> dailyExpenseSummary = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }

    return dailyExpenseSummary;
  }
}

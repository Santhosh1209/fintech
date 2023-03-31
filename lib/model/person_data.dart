import 'package:flutter/cupertino.dart';

class PersonData with ChangeNotifier {
  List<Expense> _chartData = [
    Expense(DateTime(2023, 3, 22), 25.0, 40.0),
    Expense(DateTime(2023, 3, 23), 30.0, 50.0),
    Expense(DateTime(2023, 3, 24), 20.0, 30.0),
    Expense(DateTime(2023, 3, 25), 40.0, 20.0),
    Expense(DateTime(2023, 3, 26), 15.0, 34.0),
    Expense(DateTime(2023, 3, 27), 10.0, 50.0),
    Expense(DateTime(2023, 3, 28), 35.0, 10.0),
  ];

  List<Expense> get chartData => _chartData;

  void addExpense(Expense expense) {
    _chartData.add(expense);
    notifyListeners(); // notify listeners after modifying the list
  }
}

class Expense {
  final DateTime date;
  final double outflow;
  final double inflow;

  Expense(this.date, this.outflow, this.inflow);
}
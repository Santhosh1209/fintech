import 'package:flutter/cupertino.dart';

class PersonData with ChangeNotifier {
  List<Expense> _chartData = [
    Expense(
      date: DateTime(2023, 3, 22),
      inflow: 25.0,
      outflow: 40.0,
      amount: 25.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 23),
      outflow: 30.0,
      inflow: 50.0,
      amount: 50.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 24),
      outflow: 20.0,
      inflow: 30.0,
      amount: 30.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 25),
      outflow: 40.0,
      inflow: 20.0,
      amount: 20.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 26),
      outflow: 15.0,
      inflow: 34.0,
      amount: 34.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 27),
      outflow: 10.0,
      inflow: 50.0,
      amount: 50.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 28),
      outflow: 35.0,
      inflow: 10.0,
      amount: 10.0,
      classification: "Some classification",
    )
  ];

  List<Expense> get chartData => _chartData;

  List<Expense> _threshold = [
    Expense(
      date: DateTime(2023, 3, 22),
      inflow: 25.0,
      outflow: 35.0,
      amount: 35.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 23),
      outflow: 30.0,
      inflow: 35.0,
      amount: 35.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 24),
      outflow: 20.0,
      inflow: 35.0,
      amount: 35.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 25),
      outflow: 40.0,
      inflow: 35.0,
      amount: 35.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 26),
      outflow: 15.0,
      inflow: 35.0,
      amount: 35.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 27),
      outflow: 10.0,
      inflow: 35.0,
      amount: 35.0,
      classification: "Some classification",
    ),
    Expense(
      date: DateTime(2023, 3, 28),
      outflow: 35.0,
      inflow: 35.0,
      amount: 35.0,
      classification: "Some classification",
    )
  ];

  List<Expense> get threshold => _threshold;


  void addExpense(Expense expense) {
    _chartData.add(expense);
    notifyListeners(); // notify listeners after modifying the list
  }
}

class Expense {
  final DateTime date;
  final double inflow;
  final double outflow;
  final double amount;
  final String classification;

  Expense({
    required this.date,
    required this.inflow,
    required this.outflow,
    required this.amount,
    required this.classification,
  });
}
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';

class PersonData with ChangeNotifier {
  List<Expense> _chartData = [];
  List<Expense> _threshold = [];

  List<Expense> get chartData => _chartData;

  set chartData(List<Expense> value) {
    _chartData = value;
    notifyListeners();
  }

  List<Expense> get threshold => _threshold;

  set threshold(List<Expense> value) {
    _threshold = value;
    notifyListeners();
  }

  // Default (unnamed) constructor
  PersonData();

  void addExpense(Expense expense) {
    _chartData.add(expense);
    notifyListeners();
  }

  void addThreshold(Expense threshold) {
    _threshold.add(threshold);
    notifyListeners();
  }

  // Named constructor for deserialization
  factory PersonData.fromJson(Map<String, dynamic> json) {
    List<dynamic> chartDataJson = json['chartData'];
    List<dynamic> thresholdJson = json['threshold'];

    List<Expense> chartData = chartDataJson
        .map((chartDataItem) => Expense.fromJson(chartDataItem))
        .toList();

    List<Expense> threshold = thresholdJson
        .map((thresholdItem) => Expense.fromJson(thresholdItem))
        .toList();

    return PersonData._internal(chartData, threshold);
  }

  PersonData._internal(this._chartData, this._threshold);

  // Method to convert PersonData object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'chartData': _chartData.map((expense) => expense.toJson()).toList(),
      'threshold': _threshold.map((expense) => expense.toJson()).toList(),
    };
  }
}

class Expense {
  final DateTime date;
  final double inflow;
  final double outflow;
  final double amount;
  final String? classification;
  final String? id;

  Expense({
    required this.date,
    required this.inflow,
    required this.outflow,
    required this.amount,
    required this.classification,
    this.id,
  });

  // Named constructor for deserialization
  factory Expense.fromJson(Map<String, dynamic> json) {
    double inflow = (json['amount'] as num).toDouble();
    double outflow = _calculateOutflow(inflow);

    return Expense(
      id: json['id'],
      date: DateTime.parse(json['billDate']),
      inflow: inflow,
      outflow: outflow,
      amount: inflow,
      classification: json['billType'], // Assuming billType corresponds to classification
    );
  }

  // Method to convert Expense object to a JSON map
// Method to convert Expense object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'inflow': inflow,
      'outflow': outflow,
      'amount': amount,
      'classification': classification,
    };
  }


  // Helper function to calculate random outflow
  static double _calculateOutflow(double inflow) {
    Random random = Random();
    bool shouldAdd = random.nextBool(); // Randomly decide whether to add or subtract
    double variation = shouldAdd ? 125.0 : -85.0;
    return inflow + variation;
  }
}
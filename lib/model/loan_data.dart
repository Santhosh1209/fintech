import 'package:flutter/cupertino.dart';

class LoanDetails with ChangeNotifier {
  List<LoanData> _loanDueData = [
    LoanData(DateTime(2020), 3.0),
    LoanData(DateTime(2021), 6.0),
    LoanData(DateTime(2023), 9.0),
    LoanData(DateTime(2024), 12.0),
    LoanData(DateTime(2025), 15.0),
    LoanData(DateTime(2026), 18.0),
  ];

  List<LoanData> _loanPaidData = [
    LoanData(DateTime(2020), 3.0),
    LoanData(DateTime(2021), 6.0),
    LoanData(DateTime(2023), 9.0),
  ];

  void addPaidDue(LoanData amount) {
    loanPaidData.add(amount);
    notifyListeners(); // notify listeners after modifying the list
  }

  List<LoanData> get loanDueData => _loanDueData;
  List<LoanData> get loanPaidData => _loanPaidData;

}

class LoanData {
  final DateTime date;
  final num amount;

  LoanData(this.date, this.amount);
}
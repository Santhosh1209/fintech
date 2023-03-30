import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BillTrackerPage extends StatefulWidget {
  const BillTrackerPage({super.key});

  @override
  _BillTrackerPageState createState() => _BillTrackerPageState();
}

class _BillTrackerPageState extends State<BillTrackerPage> {
  final _userName = "Sriram V"; // replace with user's name
  final _userImageURL =
      "https://i.waifu.pics/DxxMnby.jpg"; // replace with user's image URL
  final _scaffoldKey =
  GlobalKey<ScaffoldState>(); // state of scaffold to control BottomSheet

  void _showBottomSheet() {
    _scaffoldKey.currentState!.showBottomSheet((context) =>
    SizedBox(
      height: 200,
      child: Center(
        child: OutlinedButton(
          onPressed: () {
            // true
          },
          child: const Text(
            'Log in',
          ),
        ),
      ),
    ));
  }

  final List<charts.Series<Expense, DateTime>> _expenseData = [
    // replace with your own expense data
    charts.Series<Expense, DateTime>(
      id: 'Expenses',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (Expense expense, _) => expense.date,
      measureFn: (Expense expense, _) => expense.amount,
      data: [
        Expense(DateTime(2023, 3, 22), 25.0),
        Expense(DateTime(2023, 3, 23), 30.0),
        Expense(DateTime(2023, 3, 24), 20.0),
        Expense(DateTime(2023, 3, 25), 40.0),
        Expense(DateTime(2023, 3, 26), 15.0),
        Expense(DateTime(2023, 3, 27), 10.0),
        Expense(DateTime(2023, 3, 28), 35.0),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Bill Tracker"),
        ),
        body: Builder(builder: (context) =>
            Column(
                children: [
                  const SizedBox(height: 20.0),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(_userImageURL),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    _userName,
                    style: TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: charts.TimeSeriesChart(
                        _expenseData,
                        animate: true,
                        dateTimeFactory: const charts.LocalDateTimeFactory(),
                        primaryMeasureAxis: const charts.NumericAxisSpec(
                          tickProviderSpec: charts.BasicNumericTickProviderSpec(
                            desiredTickCount: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48.0),
                  FloatingActionButton(
                    onPressed: _showBottomSheet,
                    child: const Icon(Icons.ac_unit),
                  )
                ])
        ),
    );
  }
}

class Expense {
  final DateTime date;
  final double amount;

  Expense(this.date, this.amount);
}

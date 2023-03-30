import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'lists.dart';

void main() {
  runApp(billtracker());
}

class billtracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Tracker',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bill Tracker'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      LineSeries<ExpenseData, String>(
                        dataSource: [
                          ExpenseData(DateTime(2023, 03, 20), 2500),
                          ExpenseData(DateTime(2023, 03, 21), 1000),
                          ExpenseData(DateTime(2023, 03, 22), 1500),
                          ExpenseData(DateTime(2023, 03, 23), 2000),
                          ExpenseData(DateTime(2023, 03, 24), 1000),
                          ExpenseData(DateTime(2023, 03, 25), 2500),
                          ExpenseData(DateTime(2023, 03, 26), 2000),
                          ExpenseData(DateTime(2023, 03, 27), 1500),
                          ExpenseData(DateTime(2023, 03, 28), 1000),
                          ExpenseData(DateTime(2023, 03, 29), 2500),
                          ExpenseData(DateTime(2023, 03, 30), 1500),
                          ExpenseData(DateTime(2023, 03, 31), 2000),
                        ],
                        xValueMapper: (ExpenseData data, _) =>
                        '${data.date.day}/${data.date.month}/${data.date.year}',
                        yValueMapper: (ExpenseData data, _) => data.amount,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExpenseData {
  final DateTime date;
  final double amount;

  ExpenseData(this.date, this.amount);
}





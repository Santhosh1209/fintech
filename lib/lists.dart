import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class Expense {
  final DateTime date;
  final double amount;

  Expense(this.date, this.amount);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Expense> expenseData = [
    Expense(DateTime(2023, 3, 22), 25.0),
    Expense(DateTime(2023, 3, 23), 30.0),
    Expense(DateTime(2023, 3, 24), 20.0),
    Expense(DateTime(2023, 3, 25), 40.0),
    Expense(DateTime(2023, 3, 26), 15.0),
    Expense(DateTime(2023, 3, 27), 10.0),
    Expense(DateTime(2023, 3, 28), 35.0),
  ];

  List<charts.Series<Expense, DateTime>> _createData() {
    return [
      charts.Series<Expense, DateTime>(
        id: 'expenses',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Expense expense, _) => expense.date,
        measureFn: (Expense expense, _) => expense.amount,
        data: expenseData,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expenses'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${expenseData[index].date.day}/${expenseData[index].date.month}/${expenseData[index].date.year}'),
                    trailing: Text(expenseData[index].amount.toString()),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: expenseData.length,
              ),
            ),
            Container(
              height: 300,
              child: charts.TimeSeriesChart(
                _createData(),
                animate: true,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              expenseData.add(Expense(DateTime(2023, 3, 29), 30));
              expenseData.add(Expense(DateTime(2023, 3, 30), 20));
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  List<ChartData> _createData() {
    List<ChartData> chartData = [];
    for (Expense expense in expenseData) {
      chartData.add(ChartData(expense.date, expense.amount));
    }
    return chartData;
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
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewActivity()),
                );
              },
              child: Container(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  series: <ChartSeries>[
                    LineSeries<ChartData, DateTime>(
                      dataSource: _createData(),
                      xValueMapper: (ChartData chartData, _) =>
                      chartData.date,
                      yValueMapper: (ChartData chartData, _) =>
                      chartData.amount,
                    )
                  ],
                ),
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

class ChartData {
  final DateTime date;
  final double amount;

  ChartData(this.date, this.amount);
}

class NewActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Activity'),
      ),
      body: Center(
        child: Text('This is a new activity!'),
      ),
    );
  }
}

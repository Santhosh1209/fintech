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
  List<Expense> chartData = [
    Expense(DateTime(2023, 3, 22), 25.0),
    Expense(DateTime(2023, 3, 23), 30.0),
    Expense(DateTime(2023, 3, 24), 20.0),
    Expense(DateTime(2023, 3, 25), 40.0),
    Expense(DateTime(2023, 3, 26), 15.0),
    Expense(DateTime(2023, 3, 27), 10.0),
    Expense(DateTime(2023, 3, 28), 35.0),
  ];
  List<LineSeries<Expense, String>> _getDefaultLineSeries() {
    return <LineSeries<Expense, String>>[
      LineSeries<Expense, String>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (Expense expense, _) => '${expense.date.day}/${expense.date.month}',
//         xValueMapper: (Expense expense, _) => expense.date.toString(),
          yValueMapper: (Expense expense, _) => expense.amount,
          width: 2,
          name: 'Debit',
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Debit vs Credit'),
      legend: Legend(
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: CategoryAxis(
          title: AxisTitle(
              text: 'Day'
          ),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '₹{value}',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
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
                        '${chartData[index].date.day}/${chartData[index].date.month}/${chartData[index].date.year}'),
                    trailing: Text(chartData[index].amount.toString()),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: chartData.length,
              ),
            ),
            Container(
              height: 300,
              child: _buildDefaultLineChart(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              chartData.add(Expense(DateTime(2023, 3, 29), 30));
              chartData.add(Expense(DateTime(2023, 3, 30), 20));
            });
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'model/person_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
final myBaby = GetIt.instance<PersonData>();

class _MyAppState extends State<MyApp> {
  List<LineSeries<Expense, String>> _getDefaultLineSeries() {
    return <LineSeries<Expense, String>>[
      LineSeries<Expense, String>(
          animationDuration: 2500,
          dataSource: myBaby.chartData,
          xValueMapper: (Expense expense, _) => '${expense.date.day}/${expense.date.month}',
//         xValueMapper: (Expense expense, _) => expense.date.toString(),
          yValueMapper: (Expense expense, _) => expense.inflow,
          width: 2,
          name: 'Debit',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<Expense, String>(
          animationDuration: 2500,
          dataSource: myBaby.threshold,
          xValueMapper: (Expense expense, _) => '${expense.date.day}/${expense.date.month}',
//         xValueMapper: (Expense expense, _) => expense.date.toString(),
          yValueMapper: (Expense expense, _) => expense.inflow,
          width: 2,
          name: 'Safe Zone',
          markerSettings: const MarkerSettings(isVisible: false)),
    ];
  }
  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Debit vs Safe Zone'),
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
                        '${myBaby.chartData[index].date.day}/${myBaby.chartData[index].date.month}/${myBaby.chartData[index].date.year}'),
                    trailing: Text(myBaby.chartData[index].inflow.toString()),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: myBaby.chartData.length,
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
              myBaby.addExpense(Expense(DateTime(2023, 3, 29), 30, 50));
              myBaby.addExpense(Expense(DateTime(2023, 3, 30), 20, 70));
            });
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
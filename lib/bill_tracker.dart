import 'dart:core';
import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'lists.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<Expense> chartData = [
  Expense(DateTime(2023, 3, 22), 25.0),
  Expense(DateTime(2023, 3, 23), 30.0),
  Expense(DateTime(2023, 3, 24), 20.0),
  Expense(DateTime(2023, 3, 25), 40.0),
  Expense(DateTime(2023, 3, 26), 15.0),
  Expense(DateTime(2023, 3, 27), 10.0),
  Expense(DateTime(2023, 3, 28), 35.0),
];
class BillTrackerPage extends StatefulWidget {
  const BillTrackerPage({super.key});

  @override
  _BillTrackerPageState createState() => _BillTrackerPageState();
}

class _BillTrackerPageState extends State<BillTrackerPage> {
  String _userName = "Sharad"; // replace with user's name
  String _userImageURL =
      "https://example.com/user-image.png"; // replace with user's image URL
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
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
             const SizedBox(height: 20.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildDefaultLineChart(),
                ),
              ),
              TextButton(
                  onPressed:() {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                  },
                  child: Text('press panra enna')
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
  @override
  void dispose() {
    chartData.clear();
    super.dispose();
  }
}

List<LineSeries<Expense, int>> _getDefaultLineSeries() {
  return <LineSeries<Expense, int>>[
    LineSeries<Expense, int>(
        animationDuration: 2500,
        dataSource: chartData,
        xValueMapper: (Expense expense, _) => expense.date.day.toInt(),
        yValueMapper: (Expense expense, _) => expense.amount,
        width: 2,
        name: 'Debit',
        markerSettings: const MarkerSettings(isVisible: true)),
  ];
}

/// Get the cartesian chart with default line series
SfCartesianChart _buildDefaultLineChart() {
  return SfCartesianChart(
    plotAreaBorderWidth: 0,
    title: ChartTitle(text: 'Debit vs Credit'),
    legend: Legend(
        overflowMode: LegendItemOverflowMode.wrap),
    primaryXAxis: NumericAxis(
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 2,
        majorGridLines: const MajorGridLines(width: 0)),
    primaryYAxis: NumericAxis(
        labelFormat: '{value}%',
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent)),
    series: _getDefaultLineSeries(),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

class Expense {
  final DateTime date;
  final double amount;

  Expense(this.date, this.amount);
}
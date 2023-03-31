import 'dart:core';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'lists.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

var logger = Logger();

List<Expense> chartData = [
  Expense(DateTime(2023, 3, 22), 25.0, 40.0),
  Expense(DateTime(2023, 3, 23), 30.0, 50.0),
  Expense(DateTime(2023, 3, 24), 20.0, 30.0),
  Expense(DateTime(2023, 3, 25), 40.0, 20.0),
  Expense(DateTime(2023, 3, 26), 15.0, 34.0),
  Expense(DateTime(2023, 3, 27), 10.0, 50.0),
  Expense(DateTime(2023, 3, 28), 35.0, 10.0),
];
class BillTrackerPage extends StatefulWidget {
  const BillTrackerPage({super.key});

  @override
  _BillTrackerPageState createState() => _BillTrackerPageState();
}

class _BillTrackerPageState extends State<BillTrackerPage> {
  String _userName = "Sharad"; // replace with user's name
  String _userImageURL =
      "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50"; // replace with user's image URL
  final _scaffoldKey =
  GlobalKey<ScaffoldState>(); // state of scaffold to control BottomSheet
  void _showBottomSheet() {
    logger.e("bruh clidker");
    _scaffoldKey.currentState!.showBottomSheet((context) =>
        SizedBox(
          // TODO: Edit UI to fix graphs
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
  // @override
  // void dispose() {
  //   chartData.clear();
  //   super.dispose();
  // }
}

List<LineSeries<Expense, String>> _getDefaultLineSeries() {
  return <LineSeries<Expense, String>>[
    LineSeries<Expense, String>(
        animationDuration: 2500,
        dataSource: chartData,
       xValueMapper: (Expense expense, _) => '${expense.date.day}/${expense.date.month}',
        yValueMapper: (Expense expense, _) => expense.outflow,
        width: 2,
        name: 'Debit',
        markerSettings: const MarkerSettings(isVisible: true)),
    LineSeries<Expense, String>(
        animationDuration: 2500,
        dataSource: chartData,
        xValueMapper: (Expense expense, _) => '${expense.date.day}/${expense.date.month}',
        yValueMapper: (Expense expense, _) => expense.inflow,
        width: 2,
        name: 'Credit',
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

class Expense {
  final DateTime date;
  final double outflow;
  final double inflow;

  Expense(this.date, this.outflow, this.inflow);
}
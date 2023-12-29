import 'dart:core';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'model/person_data.dart';
import 'lists.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'network/adding_bill_item.dart';

var logger = Logger();
var myBaby = GetIt.I.get<PersonData>();

class BillTrackerPage extends StatefulWidget {
  const BillTrackerPage({super.key});
  @override
  _BillTrackerPageState createState() => _BillTrackerPageState();
}

class _BillTrackerPageState extends State<BillTrackerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final String _userImageURL =  "https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50";
  final String _userName = 'USER';

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('This is a bottom sheet'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Implement any action when a button in the bottom sheet is pressed
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }


  late Future<List<Expense>> _billsFuture;

  @override
  void initState() {
    super.initState();
    _billsFuture = fetchBills();
  }

  Future<List<Expense>> fetchBills() async {
    try {
      List<Expense> bills = await getBill();
      return bills;
    } catch (e) {
      print("Error fetching bills: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Bill Tracker"),
      ),
      body: Builder(
        builder: (context) {
          return FutureBuilder<List<Expense>>(
            future: _billsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // or a loading indicator
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                List<Expense> bills = snapshot.data!;
                return buildBody(bills);
              } else {
                return Text("No data");
              }
            },
          );
        },
      ),
    );
  }

  Widget buildBody(List<Expense> bills) {
    return Column(
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
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildLineChartWithBills(bills),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          child: Text(
            'Click here to see data on expenses',
          ),
        ),
        const SizedBox(height: 48.0),
        FloatingActionButton(
          onPressed: () {
            _showBottomSheet(context);
          },
          child: const Icon(Icons.ac_unit),
        )
      ],
    );
  }

  List<LineSeries<Expense, String>> _getLineSeriesWithBills(List<Expense> bills) {
    return <LineSeries<Expense, String>>[
      LineSeries<Expense, String>(
        animationDuration: 2500,
        dataSource: bills,
        xValueMapper: (Expense expense, _) => expense.date,
        yValueMapper: (Expense expense, _) => expense.outflow,
        width: 2,
        name: 'Debit',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<Expense, String>(
        animationDuration: 2500,
        dataSource: bills,
        xValueMapper: (Expense expense, _) => expense.date,
        yValueMapper: (Expense expense, _) => expense.inflow,
        width: 2,
        name: 'Credit',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
    ];
  }

  SfCartesianChart _buildLineChartWithBills(List<Expense> bills) {
    print('Number of bills: ${bills.length}');
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Debit vs Credit'),
      legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Day'),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        interval: 2,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        labelFormat: '₹{value}',
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
      ),
      series: _getLineSeriesWithBills(bills),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }
}
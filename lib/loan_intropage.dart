import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'loan_fillup.dart';
import 'model/person_data.dart';

var myBaby = GetIt.I.get<PersonData>();

class LoanTrackingPage extends StatefulWidget {
  const LoanTrackingPage({Key? key}) : super(key: key);

  @override
  _LoanTrackingPageState createState() => _LoanTrackingPageState();
}

class _LoanTrackingPageState extends State<LoanTrackingPage> {
  // Add your state variables here
  bool _isEditing = false;
  List<String> _loanNames = [
    "Business Loan",
    "Education Loan",
    "Property Loan",
  ];
  List<String> _amount = ['500000', '80000', '175000'];
  //List<String> _percentage = ['60%','75%','85%'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Tracking"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _loanNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(_loanNames[index]),
                  trailing: _isEditing
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _loanNames.removeAt(index);
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoanDetailsPage(
                                  loanName: _loanNames[index],
                                  loanAmount: _amount[index],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Card(
                  child: Row(
                    children: [
                    Text('Total Amount : '),
                    Text(_amount[index]),
                    //Text(_percentage[index])
                  ],
                )),
                _buildDefaultAreaChart(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => newLoanPage()));
        },
      ),
    );
  }
}

class LoanDetailsPage extends StatelessWidget {
  final String loanName;
  final String loanAmount;

  const LoanDetailsPage(
      {Key? key, required this.loanName, required this.loanAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loanName),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Loan details for $loanName"),
            SizedBox(height: 16),
            Text("Loan amount: $loanAmount"),
          ],
        ),
      ),
    );
  }
}
////////////////////////////////////////

List<ChartSampleData> chartData = [
  ChartSampleData(DateTime(2020), 3.0),
  ChartSampleData(DateTime(2021), 6.0),
  ChartSampleData(DateTime(2023), 9.0),
  ChartSampleData(DateTime(2024), 12.0),
  ChartSampleData(DateTime(2025), 15.0),
  ChartSampleData(DateTime(2026), 18.0),
];

List<ChartSampleData> chartDataPaid = [
  ChartSampleData(DateTime(2020), 3.0),
  ChartSampleData(DateTime(2021), 6.0),
  ChartSampleData(DateTime(2023), 9.0),
];

List<AreaSeries<ChartSampleData, DateTime>> _getDefaultAreaSeries() {
  return <AreaSeries<ChartSampleData, DateTime>>[
    AreaSeries<ChartSampleData, DateTime>(
      dataSource: chartData!,
      opacity: 0.7,
      name: 'Due',
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.y,
    ),
    AreaSeries<ChartSampleData, DateTime>(
      dataSource: chartDataPaid!,
      opacity: 0.7,
      name: 'Paid',
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.y,
    )
  ];
}

SfCartesianChart _buildDefaultAreaChart() {
  return SfCartesianChart(
    legend: Legend(opacity: 0.7),
    plotAreaBorderWidth: 0,
    primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.y(),
        interval: 1,
        intervalType: DateTimeIntervalType.years,
        majorGridLines: const MajorGridLines(width: 0),
        edgeLabelPlacement: EdgeLabelPlacement.shift),
    primaryYAxis: NumericAxis(
        labelFormat: '{value}M',
        title: AxisTitle(text: 'Paid in millions'),
        interval: 1,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0)),
    series: _getDefaultAreaSeries(),
    tooltipBehavior: TooltipBehavior(enable: true),
  );
}

class ChartSampleData {
  final DateTime x;
  final num y;

  ChartSampleData(this.x, this.y);
}

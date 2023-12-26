import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'loan_fillup.dart';
import 'model/loan_data.dart';
import 'About_loan.dart';

class LoanInfo {
  final String name;
  final String amount;
  final String type;
  final String rate;
  final String duration;

  LoanInfo({
    required this.name,
    required this.amount,
    required this.type,
    required this.rate,
    required this.duration,
  });
}

var myLoan = GetIt.I.get<LoanDetails>();

class LoanTrackingPage extends StatefulWidget {
  const LoanTrackingPage({Key? key}) : super(key: key);

  @override
  _LoanTrackingPageState createState() => _LoanTrackingPageState();
}

class _LoanTrackingPageState extends State<LoanTrackingPage> {
  bool _isEditing = false;

  List<LoanInfo> _loanInfoList = [
    LoanInfo(name: "Business Loan", amount: '500000', type: 'Business Loan', rate: '5%', duration: '3 years'),
    LoanInfo(name: "Education Loan", amount: '80000', type: 'Education Loan', rate: '8%', duration: '2 years'),
    LoanInfo(name: "Property Loan", amount: '175000', type: 'Property Loan', rate: '10%', duration: '5 years'),
    // Add more loans as needed
  ];

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
        itemCount: _loanInfoList.length,
        itemBuilder: (BuildContext context, int index) {
          var loan = _loanInfoList[index];
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(loan.name),
                  trailing: _isEditing
                      ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _loanInfoList.removeAt(index);
                      });
                    },
                  )
                      : IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutLoanPage(
                            loanName: loan.name,
                            loanAmount: loan.amount,
                            loanType: loan.type,
                            interestRate: loan.rate,
                            duration: loan.duration,
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
                      Text(loan.amount),
                    ],
                  ),
                ),
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
              context, MaterialPageRoute(builder: (context) => NewLoanPage()));
        },
      ),
    );
  }

  List<AreaSeries<LoanData, DateTime>> _getDefaultAreaSeries() {
    return <AreaSeries<LoanData, DateTime>>[
      AreaSeries<LoanData, DateTime>(
        dataSource: myLoan.loanDueData!,
        opacity: 0.7,
        name: 'Due',
        xValueMapper: (LoanData sales, _) => sales.date,
        yValueMapper: (LoanData sales, _) => sales.amount,
      ),
      AreaSeries<LoanData, DateTime>(
        dataSource: myLoan.loanPaidData!,
        opacity: 0.7,
        name: 'Paid',
        xValueMapper: (LoanData sales, _) => sales.date,
        yValueMapper: (LoanData sales, _) => sales.amount,
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
}
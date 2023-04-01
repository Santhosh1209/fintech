import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'loan_fillup.dart';

class LoanTrackingPage extends StatefulWidget {
  const LoanTrackingPage({Key? key}) : super(key: key);

  @override
  _LoanTrackingPageState createState() => _LoanTrackingPageState();
}

class _LoanTrackingPageState extends State<LoanTrackingPage> {
  // Add your state variables here
  bool _isEditing = false;
  List<String> _loanNames = [    "Loan 1",    "Loan 2",    "Loan 3",  ];
  List<String> _amount = ['500000','80000','175000'];
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
                  child : Row(
                    children: [
                      Text ('Total Amount : '),
                      Text(_amount[index]),
                      //Text(_percentage[index])
                    ],
                  )
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => newLoanPage()));
          },
      ),
    );
  }
}

class LoanDetailsPage extends StatelessWidget {
  final String loanName;
  final String loanAmount;

  const LoanDetailsPage({Key? key, required this.loanName, required this.loanAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loanName),
      ),
      body: Center(
        child:
        Column(
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
}SfCartesianChart _buildDefaultLineChart() {
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
List<Expense> chartData = [
  Expense(DateTime(2023, 3, 22), 25.0, 40.0),
  Expense(DateTime(2023, 3, 23), 30.0, 50.0),
  Expense(DateTime(2023, 3, 24), 20.0, 30.0),
  Expense(DateTime(2023, 3, 25), 40.0, 20.0),
  Expense(DateTime(2023, 3, 26), 15.0, 34.0),
  Expense(DateTime(2023, 3, 27), 10.0, 50.0),
  Expense(DateTime(2023, 3, 28), 35.0, 10.0),
];

// NavigationRail(
// destinations: <NavigationRailDestination>
// [
//
// ]
// )
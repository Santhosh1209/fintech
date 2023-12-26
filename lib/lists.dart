import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'model/person_data.dart';
import 'network/adding_bill_item.dart';

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
        xValueMapper: (Expense expense, _) =>
        '${expense.date.day}/${expense.date.month}',
        yValueMapper: (Expense expense, _) => expense.inflow,
        width: 2,
        name: 'Debit',
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<Expense, String>(
        animationDuration: 2500,
        dataSource: myBaby.threshold,
        xValueMapper: (Expense expense, _) =>
        '${expense.date.day}/${expense.date.month}',
        yValueMapper: (Expense expense, _) => expense.amount,
        width: 2,
        name: 'Safe Zone',
        markerSettings: const MarkerSettings(isVisible: false),
      ),
    ];
  }

  SfCartesianChart _buildDefaultLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Debit vs Safe Zone'),
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
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }


  void _editExpense(BuildContext context, Expense expense) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AddingBillItemPage(
          // Pass the expense data to the AddingBillItemPage
          initialAmount: expense.amount.toString(),
          initialDate: expense.date.toString(),
          initialClassification: expense.classification,
          onSave: (newDebit, newDate, newClassification) {
            // Find the index of the expense in the list
            int index = myBaby.chartData.indexOf(expense);

            // Update the existing expense
            myBaby.chartData[index] = Expense(
              date: DateTime.parse(newDate),
              inflow: newDebit,
              outflow: expense.outflow, // Keep the original outflow value
              amount: newDebit,
              classification: newClassification,
            );

            // Notify listeners after modifying the list
            myBaby.notifyListeners();

          },
        ),
      ),
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
                final Expense expense = myBaby.chartData[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                      ),
                      Row(
                        children: [
                          Text(
                            '${expense.amount >= 0 ? 'Debit: ${expense.amount}' : 'Credit: ${-expense.amount}'}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editExpense(context, expense);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddingBillItemPage(
                onSave: (newAmount, newDate, newClassification) {
                  setState(() {
                    myBaby.addExpense(Expense(
                      date: DateTime.parse(newDate),
                      inflow: newAmount,
                      outflow: newAmount >= 0 ? 0.0 : -newAmount,
                      amount: newAmount,
                      classification: newClassification,
                    ));
                  });

                  // Navigate back to the list of values page
                  Navigator.pop(context);
                },

              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
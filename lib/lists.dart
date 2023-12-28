import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'model/person_data.dart';
import 'network/adding_bill_item.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

final myBaby = GetIt.instance<PersonData>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

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

  void _editExpense(BuildContext context, AddingBillItemPage billItem) {

    // Convert initialAmount to double
    double initialAmount = double.parse(billItem.initialAmount ?? '0.0');

    // Convert AddingBillItem to Expense
    Expense expenseToUpdate = Expense(
      id: billItem.id ?? null, // Ensure that the id is retained
      date: DateTime.parse(billItem.initialDate ?? ''),
      inflow: initialAmount,
      outflow: (Random().nextInt(2) == 1) ? initialAmount + 125.0 : initialAmount - 85.0,
      amount: initialAmount,
      classification: billItem.initialClassification ?? '',
    );
    print('Editing expense with id: ${expenseToUpdate.id}'); // Print the id
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddingBillItemPage(
          // Pass the expense data to the AddingBillItemPage
          id: expenseToUpdate.id,
          initialAmount: expenseToUpdate.amount.toString(),
          initialDate: expenseToUpdate.date.toLocal().toString().split(' ')[0],
          initialClassification: expenseToUpdate.classification,
          onSave: (newDebit, newCredit, newDate, newClassification) {
            // Find the index of the expense in the list
            int index = myBaby.chartData.indexWhere((expense) => expense.id == expenseToUpdate.id);

            // Update the existing expense
            myBaby.chartData[index] = Expense(
              id: expenseToUpdate.id, // Ensure that the id is retained
              date: DateTime.parse(newDate),
              inflow: double.parse(newDebit.toString() ?? '0.0'),
              outflow: double.parse(newCredit.toString() ?? '0.0'),
              amount: double.parse(newDebit.toString() ?? '0.0'),
              classification: newClassification ?? '',
            );

            // Notify listeners after modifying the list
            myBaby.notifyListeners();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadBills();
  }

  Future<void> _loadBills() async {
    try {
      List<Expense> bills = await getBill();
      setState(() {
        myBaby.chartData = bills;
      });
    } catch (e) {
      print("Error loading bills: $e");
    }
  }

  AddingBillItemPage convertExpenseToAddingBillItemPage(Expense expense) {
    print('Expense ID: ${expense.id}');
    return AddingBillItemPage(
      id: expense.id,
      initialAmount: expense.amount.toString(),
      initialDate: expense.date.toString(),
      initialClassification: expense.classification,
      onSave: (newDebit, newCredit, newDate, newClassification) {
        // Handle the onSave logic if needed
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: myBaby,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Expenses'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<PersonData>(
                builder: (context, personData, child) {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final Expense expense = personData.chartData[index];
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
                                    print('Editing expense with ID: ${expense.id}');
                                    _editExpense(context, convertExpenseToAddingBillItemPage(expense));
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: personData.chartData.length,
                  );
                },
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
                  onSave: (newAmount, newCredit, newDate, newClassification) {
                    setState(() {
                      myBaby.addExpense(Expense(
                        date: DateTime.parse(newDate),
                        inflow: newAmount,
                        outflow: newCredit,
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
      ),
    );
  }
}
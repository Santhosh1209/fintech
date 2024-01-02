import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'EditBillPage.dart';
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
  bool deleting = false;
  int? expenseToDeletePivot;

  List<LineSeries<Expense, String>> _getDefaultLineSeries() {
    return <LineSeries<Expense, String>>[
      LineSeries<Expense, String>(
        animationDuration: 2500,
        dataSource: myBaby.chartData,
        xValueMapper: (Expense expense, _) => DateFormat('dd/MM').format(DateTime.parse(expense.date)),
        yValueMapper: (Expense expense, _) => expense.inflow,
        width: 2,
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<Expense, String>(
        animationDuration: 2500,
        dataSource: myBaby.threshold,
        xValueMapper: (Expense expense, _) => DateFormat('dd/MM').format(DateTime.parse(expense.date)),
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

  Future<void> deleteBill(int? pivot) async {
    var url = Uri.parse('https://fintech-rfnl.onrender.com/api/bill/${pivot ?? ''}');
    final storage = FlutterSecureStorage();
    String key = 'access_token';
    String? chumma = await storage.read(key: key);
    String sathish = "Bearer ";
    String concatenatedString = sathish + chumma!;

    var headers = {
      'Authorization': concatenatedString,
      'Content-Type': 'application/json',
    };

    try {
      var response = await http.delete(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('DELETE response: $data');
      } else {
        throw Exception('Failed to make DELETE request');
      }
    } catch (error) {
      print('Error making DELETE request: $error');
    } finally {
      setState(() {
        deleting = false;
      });
      // Load bills after deletion is complete
      _loadBills();
    }
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
                  return FutureBuilder(
                    future: deleting ? deleteBill(expenseToDeletePivot) : null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            final Expense expense = personData.chartData[index];
                            return ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${DateTime.parse(expense.date).day}/${DateTime.parse(expense.date).month}/${DateTime.parse(expense.date).year}',
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
                                          print('Editing expense with Pivot: ${expense.pivot != null ? expense.pivot : 'ID not available'}');
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditBillPage(pivot: expense.pivot, expense: expense),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            expenseToDeletePivot = expense.pivot;
                                            deleting = true;
                                          });
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: personData.chartData.length,
                        );
                      }
                    },
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
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddingBillItemPage(
                  onSave: (newAmount, newCredit, newDate, newClassification) async {
                    myBaby.addExpense(Expense(
                      date: DateTime.parse(newDate).toString(),
                      inflow: newAmount,
                      outflow: newCredit,
                      amount: newAmount,
                      classification: newClassification,
                    ));
                  },
                  onNewBillAdded: _loadBills,
                  onLoadBills: _loadBills,
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

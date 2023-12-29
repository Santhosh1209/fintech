import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'main.dart';
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
        xValueMapper: (Expense expense, _) => expense.date,
        yValueMapper: (Expense expense, _) => expense.inflow,
        width: 2,
        markerSettings: const MarkerSettings(isVisible: true),
      ),
      LineSeries<Expense, String>(
        animationDuration: 2500,
        dataSource: myBaby.threshold,
        xValueMapper: (Expense expense, _) => expense.date,
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

  void _editExpense(BuildContext context, Expense expenseToUpdate) {
    print('Editing expense with id: ${expenseToUpdate.pivot}');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddingBillItemPage(
          pivot: expenseToUpdate.pivot,
          initialAmount: expenseToUpdate.amount.toString(),
          initialDate: expenseToUpdate.date,
          initialClassification: expenseToUpdate.classification,
          onSave: (newDebit, newCredit, newDate, newClassification) {
            int index = myBaby.chartData.indexWhere((expense) => expense.pivot == expenseToUpdate.pivot);

            if (index != -1) {
              myBaby.chartData[index].date = DateTime.parse(newDate).toString();
              myBaby.chartData[index].inflow = double.parse(newDebit.toString() ?? '0.0');
              myBaby.chartData[index].outflow = double.parse(newCredit.toString() ?? '0.0');
              myBaby.chartData[index].amount = double.parse(newDebit.toString() ?? '0.0');
              myBaby.chartData[index].classification = newClassification ?? '';

              editBill(
                myBaby.chartData[index].amount,
                myBaby.chartData[index].classification,
                myBaby.chartData[index].date,
                myBaby.chartData[index].pivot,
              );
            } else {
              print("saveExpense()");
            }
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

  // AddingBillItemPage convertExpenseToAddingBillItemPage(Expense expense) {
  //   print('Expense ID: ${expense.id}');
  //   return AddingBillItemPage(
  //     id: expense.id,
  //     initialAmount: expense.amount.toString(),
  //     initialDate: expense.date.toString(),
  //     initialClassification: expense.classification,
  //     onSave: (newDebit, newCredit, newDate, newClassification) {
  //       // Handle the onSave logic if needed
  //     },
  //   );
  // }


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
                                '${DateTime.parse(expense.date).day}/${DateTime.parse(expense.date).month}/${DateTime.parse(expense.date).year}'
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
                                    print('Editing expense with ID: ${expense.pivot}');
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
                        date: DateTime.parse(newDate).toString(),
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

// backend integration
// (iii) - PUT -> used for editing bills
Future<void> editBill(double amountParam, String classificationParam, String dateParam, int? pivotParam) async {
  double amount = amountParam;
  String classification = classificationParam;
  String date = dateParam;
  int? pivot = pivotParam;

  var url = Uri.parse('https://fintech-rfnl.onrender.com/api/bill/${pivot ?? ''}');

  final storage = FlutterSecureStorage();
  String key = 'access_token';
  String? chumma = await storage.read(key: key);

  String sathish = "Bearer ";
  String concatenatedString = sathish + chumma!;
  var headers = {'Authorization': concatenatedString, 'Content-Type': 'application/json'};

  var payload = {
    'amount': amount,
    'billType': classification,
    'billDate': date,
  };

  try {
    var response = await http.put(
      url,
      headers: headers,
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('PUT response: $data');

      // Fetch the updated list of bills from the server
      await fetchUpdatedBills();

      // Optional: You can add additional logic after fetching the updated list
    } else {
      throw Exception('Failed to make PUT request');
    }
  } catch (error) {
    print('Error making PUT request: $error');
  }
}

Future<void> fetchUpdatedBills() async {
  try {
    // Fetch the updated list of bills from the server
    var url = Uri.parse('https://fintech-rfnl.onrender.com/api/bills');
    final storage = FlutterSecureStorage();
    String key = 'access_token';
    String? chumma = await storage.read(key: key);

    String sathish = "Bearer ";
    String concatenatedString = sathish + chumma!;
    var headers = {'Authorization': concatenatedString, 'Content-Type': 'application/json'};
    var response = await http.get(
        url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var updatedBills = json.decode(response.body);

      // Update your local list with the fetched data
      myBaby.chartData = List<Expense>.from(
        updatedBills.map((bill) {
          Random random = Random();
          int x = random.nextInt(2);
          double amount = bill['amount'];

          double outflow = (x == 1) ? amount + 175.0 : amount - 85.0;
          double inflow = amount;

          return Expense(
            pivot: bill['pivot'],
            amount: amount,
            classification: bill['billType'],
            date: bill['billDate'],
            outflow: outflow,
            inflow: inflow,
          );
        }),
      );

      myBaby.notifyListeners(); // Notify listeners after modifying the list
    } else {
      throw Exception('Failed to fetch updated bills');
    }
  } catch (error) {
    print('Error fetching updated bills: $error');
  }
}
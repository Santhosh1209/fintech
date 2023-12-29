import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import '../lists.dart';
import '../main.dart';
import '../model/person_data.dart';
import 'package:fintech/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddingBillItemPage extends StatefulWidget {
  final String? initialAmount;
  final String? initialDate;
  final String? initialClassification;
  int? pivot;
  final Function(double, double, String, String) onSave;

  AddingBillItemPage({
    Key? key,
    required this.onSave,
    this.pivot,
    this.initialAmount,
    this.initialDate,
    this.initialClassification,
  }) : super(key: key);

  @override
  _AddingBillItemPageState createState() => _AddingBillItemPageState();
}

class _AddingBillItemPageState extends State<AddingBillItemPage> {
  final myBaby = GetIt.instance<PersonData>();

  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController classificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Here, we are fixing the initial values if they're provided
    amountController.text = widget.initialAmount ?? '';
    dateController.text = widget.initialDate ?? '';
    classificationController.text = widget.initialClassification ?? '';

    // Ensure that the id is retained
    widget.pivot = widget.pivot ?? null;
  }

  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text('Add Bill Item'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(
                controller: amountController,
                label: 'Amount',
                prefixText: '₹',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              _buildTextField(
                controller: dateController,
                label: 'Date (dd/mm/yyyy)',
                hintText: 'e.g., 01/12/2023',
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16.0),
              _buildTextField(
                controller: classificationController,
                label: 'Classification',
                hintText: 'e.g., Food, Travel, Health, Home, Others',
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildButton(
                    text: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context); // Cancel button
                    },
                  ),
                  _buildButton(
                    text: 'Save',
                    onPressed: () {
                      _saveExpense();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp())); // Replace the current route
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      print("Error in build method: $e");
      // Return an error message or a suitable widget in case of an exception
      return Center(
        child: Text("Error loading UI"),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    String? prefixText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixText: prefixText,
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> _saveExpense() async {
    try {
      // Ensure that amount is not empty
      if (amountController.text.isEmpty) {
        // You can handle this case as per your requirements
        return;
      }

      double debit = double.parse(amountController.text);
      Random random = Random();
      int x = random.nextInt(2);
      double credit = (x == 1) ? debit + 175.0 : debit - 85.0;
      String date = dateController.text;
      String classification = classificationController.text;

      // Check if the date is in the correct format
      DateTime? parsedDate = DateTime.tryParse(date);
      if (parsedDate == null) {
        // Handle incorrect date format as needed
        return;
      }

      // Call the onSave callback
      widget.onSave(debit, credit, parsedDate.toString(), classification);
      if (mounted) {
        List<dynamic> existingBills = await getBill();
        int newId = (existingBills.isEmpty) ? 1 : existingBills.length + 1;
        widget.pivot = newId;
        print('After updating widget.id: ${widget.pivot}');
      }
      if (widget.pivot == null) {
        print('widget.id is null');
      } else {
        print('widget.id is not null');
      }
        addBill(debit, classification, parsedDate.toString(), widget.pivot);
    }catch (e) {
      print("Error saving expense: $e");
      // Handle the error as needed
    }
  }
  }

  Widget _buildButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.black, width: 2.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }

// backend integration
// - (i) POST
void addBill(double amount, String classification, String date ,int? pivot) async {
  print("Vanakam");
  var url = Uri.parse('https://fintech-rfnl.onrender.com/api/bill/');

  final storage = FlutterSecureStorage();
  String key = 'access_token';
  String? chumma = await storage.read(key: key);

  String sathish = "Bearer ";
  String concatenatedString = sathish + chumma!;
  var headers = { 'Authorization': concatenatedString,
    'Content-Type': 'application/json'};

  var payload = {
    'pivot':pivot,
    'amount': amount,
    'billType': classification,
    'billDate': date
  };

  try {
    print("Vanakam2");
    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      print("Vanakam3");
      var data = json.decode(response.body);
      print('POST response: $data');
    } else {
      print("Vanakam4");
      throw Exception('Failed to make POST request');
    }
  } catch (error) {
    print("Vanakam5");
    print('Error making POST request: $error');
  }
}

// - (ii) GET -> loads array of bills of a particular user
Future<List<Expense>> getBill() async {
  print("Vanakam");
  var url = Uri.parse('https://fintech-rfnl.onrender.com/api/bill/');
  final storage = FlutterSecureStorage();
  String key = 'access_token';
  String? chumma = await storage.read(key: key);
  String sathish = "Bearer ";
  String concatenatedString = sathish + chumma!;

  var headers = {'Authorization': concatenatedString, 'Content-Type': 'application/json'};

  try {
    print("Vanakam2");
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      print("Vanakam3");
      var data = json.decode(response.body);
      print('GET response: $data');
      // Convert the data into a list of Expense objects
      List<Expense> bills = (data as List)
          .map((billData) => Expense.fromJson(billData))
          .toList();
      return bills;
    } else {
      print("Vanakam4");
      throw Exception('Failed to make GET request');
    }
  } catch (error) {
    print("Vanakam5");
    print('Error making GET request: $error');
    return [];
  }
}

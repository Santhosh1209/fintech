import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'bill_tracker.dart';
import 'model/person_data.dart';
import 'package:http/http.dart' as http;

class EditBillPage extends StatefulWidget {
  // You can pass the necessary data to edit in the constructor if needed
  final int? pivot;
  final Expense? expense;

  EditBillPage({required this.pivot,this.expense});

  @override
  _EditBillPageState createState() => _EditBillPageState();
}

class _EditBillPageState extends State<EditBillPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController classificationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controllers with data from the received Expense object
    if (widget.expense != null) {
      amountController.text = widget.expense!.amount.toString();
      dateController.text = widget.expense!.date;
      classificationController.text = widget.expense!.classification;
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit Bill Item'),
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
                label: 'Date (yyyy/mm/dd)',
                hintText: 'e.g., 2023/12/09',
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
                      //editBill(expense.amount, expense.classification, expense.date, expense.pivot)
                      Navigator.pop(context); // Navigate back after saving
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
    Widget _buildButton({
      required String text,
      required VoidCallback onPressed,
    }) {
      return ElevatedButton(
        onPressed: () {
          // Get values from controllers
          double amount = double.tryParse(amountController.text) ?? 0.0;
          String classification = classificationController.text;
          String date = dateController.text;
          int? pivot = widget.pivot;

          // Call the editBill function with user's changes
          editBill(amount, classification, date, pivot);

          // Navigate back after saving
          Navigator.pop(context);
        },
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

// Add your _buildTextField and _buildButton functions here

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

    } else {
      throw Exception('Failed to make PUT request');
    }
  } catch (error) {
    print('Error making PUT request: $error');
  }
}
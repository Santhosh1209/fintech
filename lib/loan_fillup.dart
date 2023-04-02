import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class newLoanPage extends StatefulWidget {
  const newLoanPage({Key? key}) : super(key: key);

  @override
  State<newLoanPage> createState() => _newLoanPageState();
}

class _newLoanPageState extends State<newLoanPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedPaymentMode;

  Future<void> _selectDateTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        final DateTime selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        // do something with the selected date and time
      }
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new loan'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Enter the following details to create a new loan',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Card(
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter your total loan amount',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your loan amount';
                }
                return null;
              },
            ),
          ),
          Spacer(

          ),
          Card(
            child: InkWell(
              onTap: _selectDateTime,
              child: IgnorePointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    hintText: 'Select loan start date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (_selectedDate == null) {
                      return 'Please select loan start date';
                    }
                    return null;
                  },
                  controller: TextEditingController(
                      text: _selectedDate == null
                          ? ''
                          : DateFormat.yMMMd().format(_selectedDate!)),
                ),
              ),
            ),
          ),
          Spacer(

          ),
          Card(
            child: InkWell(
              onTap: _selectDateTime,
              child: IgnorePointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    hintText: 'Select loan end date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (_selectedDate == null) {
                      return 'Please select loan start date';
                    }
                    return null;
                  },
                  controller: TextEditingController(
                      text: _selectedDate == null
                          ? ''
                          : DateFormat.yMMMd().format(_selectedDate!)),
                ),
              ),
            ),
          ),
          Spacer(

          ),
          Card(
            child: DropdownButtonFormField<String>(
              value: _selectedPaymentMode,
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMode = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Payment Mode',
                hintText: 'Select payment mode',
              ),
              validator: (value) {
                if (_selectedPaymentMode == null) {
                  return 'Please select payment mode';
                }
                return null;
              },
              items: ['Daily', 'Weekly', 'Monthly']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Spacer
            (),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            TextButton(onPressed:
                ()
            {
              //
            },
                child: Text('Cancel',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
              TextButton(onPressed:
                  ()
              {
                //
              },
                  child: Text('Save',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ))
              ),
            ],
          )
        ],
      ),
    );
  }
}




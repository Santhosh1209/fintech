// import 'package:flutter/material.dart';
// // import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:intl/intl.dart';
//
// class newLoanPage extends StatefulWidget {
//   const newLoanPage({Key? key}) : super(key: key);
//
//   @override
//   State<newLoanPage> createState() => _newLoanPageState();
// }
//
// class _newLoanPageState extends State<newLoanPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   DateTime? _selectedDate;
//   String? _selectedPaymentMode;
//
//   Future<void> _selectDateTime() async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null) {
//       final TimeOfDay? time = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//       );
//       if (time != null) {
//         final DateTime selectedDateTime = DateTime(
//           picked.year,
//           picked.month,
//           picked.day,
//           time.hour,
//           time.minute,
//         );
//         // do something with the selected date and time
//       }
//     }
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add a new loan'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(10.0),
//               child: Center(
//                 child: Text(
//                   'Enter the following details to create a new loan',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 12.0,
//                     fontWeight: FontWeight.normal,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Card(
//             child: TextFormField(
//               controller: _amountController,
//               decoration: InputDecoration(
//                 labelText: 'Amount',
//                 hintText: 'Enter your total loan amount',
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'Please enter your loan amount';
//                 }
//                 return null;
//               },
//             ),
//           ),
//           Spacer(
//
//           ),
//           Card(
//             child: InkWell(
//               onTap: _selectDateTime,
//               child: IgnorePointer(
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'Start Date',
//                     hintText: 'Select loan start date',
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: (value) {
//                     if (_selectedDate == null) {
//                       return 'Please select loan start date';
//                     }
//                     return null;
//                   },
//                   controller: TextEditingController(
//                       text: _selectedDate == null
//                           ? ''
//                           : DateFormat.yMMMd().format(_selectedDate!)),
//                 ),
//               ),
//             ),
//           ),
//           Spacer(
//
//           ),
//           Card(
//             child: InkWell(
//               onTap: _selectDateTime,
//               child: IgnorePointer(
//                 child: TextFormField(
//                   decoration: InputDecoration(
//                     labelText: 'End Date',
//                     hintText: 'Select loan end date',
//                     suffixIcon: Icon(Icons.calendar_today),
//                   ),
//                   validator: (value) {
//                     if (_selectedDate == null) {
//                       return 'Please select loan start date';
//                     }
//                     return null;
//                   },
//                   controller: TextEditingController(
//                       text: _selectedDate == null
//                           ? ''
//                           : DateFormat.yMMMd().format(_selectedDate!)),
//                 ),
//               ),
//             ),
//           ),
//           Spacer(
//
//           ),
//           Card(
//             child: DropdownButtonFormField<String>(
//               value: _selectedPaymentMode,
//               onChanged: (value) {
//                 setState(() {
//                   _selectedPaymentMode = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Payment Mode',
//                 hintText: 'Select payment mode',
//               ),
//               validator: (value) {
//                 if (_selectedPaymentMode == null) {
//                   return 'Please select payment mode';
//                 }
//                 return null;
//               },
//               items: ['Daily', 'Weekly', 'Monthly']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//           ),
//           Spacer
//             (),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//             TextButton(onPressed:
//                 ()
//             {
//               //
//             },
//                 child: Text('Cancel',
//                   style: TextStyle(
//                       fontFamily: 'Poppins',
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )
//             ),
//               TextButton(onPressed:
//                   ()
//               {
//                 //
//               },
//                   child: Text('Save',
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.bold,
//                   ))
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewLoanPage extends StatefulWidget {
  const NewLoanPage({Key? key}) : super(key: key);

  @override
  State<NewLoanPage> createState() => _NewLoanPageState();
}

final _formKey = GlobalKey<FormState>();
final TextEditingController _amountController = TextEditingController();
final TextEditingController _startDateController = TextEditingController();
final TextEditingController _endDateController = TextEditingController();
String? _selectedPaymentMode;
String? _selectedLoanType;
String? _selectedInterestRate; // Added variable for selected interest rate
String accessToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1NjMwNDBiY2RkZjQ4NWRiYzlhNDNjYSIsImlhdCI6MTcwMDk4NzkxNSwiZXhwIjoxNzAxMjQ3MTE1fQ.PltdbntLDLvI4ItZsuW9NmcITaO3qUl8cC9YuZkkL3Q';

class _NewLoanPageState extends State<NewLoanPage> {
  List<String> _loanTypes = ['Home Loan', 'Business Loan', 'Education Loan', 'Property Loan', 'Gold Loan'];
  List<String> _interestRates = ['5%', '8%', '10%', '12%', '15%'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new loan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
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
          SizedBox(height: 10.0),
          Card(
            child: TextFormField(
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
              onChanged: (value) {
                _amountController.text = value;
              },
            ),
          ),
          SizedBox(height: 10.0),
          Card(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Start Date',
                hintText: 'Enter loan start date (MM/dd/yyyy)',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter loan start date';
                }
                return null;
              },
              onChanged: (value) {
                _startDateController.text = value;
              },
            ),
          ),
          SizedBox(height: 10.0),
          Card(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'End Date',
                hintText: 'Enter loan end date (MM/dd/yyyy)',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter loan end date';
                }
                return null;
              },
              onChanged: (value) {
                _endDateController.text = value;
              },
            ),
          ),
          SizedBox(height: 10.0),
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
          SizedBox(height: 10.0),
          Card(
            child: DropdownButtonFormField<String>(
              value: _selectedLoanType,
              onChanged: (value) {
                setState(() {
                  _selectedLoanType = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Loan Type',
                hintText: 'Select loan type',
              ),
              validator: (value) {
                if (_selectedLoanType == null) {
                  return 'Please select loan type';
                }
                return null;
              },
              items: _loanTypes
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10.0),
          Card(
            child: DropdownButtonFormField<String>(
              value: _selectedInterestRate,
              onChanged: (value) {
                setState(() {
                  _selectedInterestRate = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Interest Rate',
                hintText: 'Select interest rate',
              ),
              validator: (value) {
                if (_selectedInterestRate == null) {
                  return 'Please select interest rate';
                }
                return null;
              },
              items: _interestRates
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  // Handle cancel action
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  postData_loan();
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// backend integration
void postData_loan() async {
  print("Vanakam");
  var url = Uri.parse('https://fintech-rfnl.onrender.com/api/loan/');
  var headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };

  var payload = {
    'amount': _amountController.text,
    'startDate': _startDateController.text,
    'endDate': _endDateController.text,
    'loanType': _selectedPaymentMode
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



import 'package:flutter/material.dart';

class AboutLoanPage extends StatelessWidget {
  final String loanName;
  final String loanAmount;
  final String? loanType;
  final String? interestRate;
  final String? duration;

  const AboutLoanPage({
    Key? key,
    required this.loanName,
    required this.loanAmount,
    this.loanType,
    this.interestRate,
    this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Loan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loan Details for $loanName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Loan Amount: $loanAmount'),
            Text('Loan Type: ${loanType ?? "N/A"}'),
            Text('Interest Rate: ${interestRate ?? "N/A"}'),
            if (duration != null) Text('Duration: $duration'),
            // Add more loan details as needed
          ],
        ),
      ),
    );
  }
}
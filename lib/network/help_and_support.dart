import 'package:flutter/material.dart';

class HelpAndSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Email: support@yourfintechapp.com',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Phone: +91 98765 43201',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'About Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Welcome to Your Fintech App! We help you manage your finances effortlessly with our user-friendly app.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'FAQs',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Q: How do I reset my password?\nA: You can reset your password by going to the login page and selecting the "Forgot Password" option.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Q: Can I update my profile information?\nA: Yes, you can update your profile information on the "Edit Profile" page.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Q: Who can use Your Fintech App?\nA: Anyone can use our app! Whether you are an individual managing personal finances or a business owner keeping track of expenses, our app is designed for everyone.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Q: How can I categorize my transactions?\nA: You can categorize your transactions by using the "Add Expense" feature. Our app provides predefined categories, and you can also create custom categories based on your needs.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                'Q: Is my financial data secure?\nA: Yes, we prioritize the security of your financial data. Your data is encrypted, and we implement strict security measures to protect your information.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HelpAndSupportPage(),
  ));
}

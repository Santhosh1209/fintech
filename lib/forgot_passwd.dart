import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  bool showOtpField = false;
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your email to receive a password reset OTP:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                sendOtp();
              },
              child: Text('Send OTP'),
            ),
            if (showOtpField)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Enter the OTP you received:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  PinCodeTextField(
                    controller: otpController,
                    appContext: context,
                    length: 6,
                    onChanged: (value) {
                      otp = value;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      verifyOtp();
                    },
                    child: Text('Verify OTP'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void sendOtp() async {
    otp = generateOtp();

    final Email email = Email(
      body: 'Your OTP is $otp',
      subject: 'Password Reset OTP',
      recipients: [emailController.text],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

    setState(() {
      showOtpField = true;
    });
  }

  String generateOtp() {
    Random random = Random();
    int otp = random.nextInt(900000) + 100000;
    return otp.toString();
  }

  void verifyOtp() {
    if (otpController.text == otp) {
      Navigator.pushNamed(context, '/reset_password');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Invalid OTP'),
            content: Text('Please enter the correct OTP.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}


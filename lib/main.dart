import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
//import 'package:charts_flutter/flutter.dart' as charts;
import 'bill_tracker.dart';
import 'signup.dart';
import 'forgot_passwd.dart';

void main() {
  runApp(const homepage());
}
class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: fintech(),
          ),
        ),
      ),
    );
  }
}

class fintech extends StatefulWidget {
  const fintech({Key? key}) : super(key: key);

  @override
  State<fintech> createState() => _fintechState();
}

class _fintechState extends State<fintech> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image(image:
      //NetworkImage('file:///C:/Users/P.%20Santhosh/Downloads/Rain%20Credit.png'),
          AssetImage('images/Rain Credit.png'),
      ),
        Expanded(
          flex: 2,
          child:
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Gain total control of your money',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child:
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Register now to start tracking your expenses and achieving your financial goals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black38,
                ),
              ),
            ),
          ),
        ),
        Expanded
          (
          child:
          Padding(
            padding: EdgeInsets.all(20.0),
            child:
            SizedBox(
    width: 250,
    child : TextButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()
                ));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          ),
        ),
        Expanded
          (
          child:
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox
              (
              width: 250,
              child: TextButton(
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: Text(
                'Log in',
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            ),
          ),
        ),
      ],
    );
  }
}




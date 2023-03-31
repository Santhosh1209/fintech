import 'package:fintech/model/person_data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
// Pages
import 'login.dart';
import 'model/loan_data.dart';
import 'signup.dart';

void main() {
  // This is the Service Locator
  // Using this you can get instance of registered classes anywhere
  GetIt locator = GetIt.instance;
  locator.registerSingleton<PersonData>(PersonData());
  locator.registerSingleton<LoanDetails>(LoanDetails());

  runApp(const homepage());
}

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: fintech(),
          ),
        ),
      ),
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
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
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18.0, fontFamily: 'Inter'));

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Image(
            image: AssetImage('images/Rain Credit.png'),
          ),
          const Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Gain total control of your money',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  'Register now to start tracking your expenses and achieving your financial goals',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  style: style,
                  child: const Text(
                    'Sign up',
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => loginPage()));
                },
                style: style,
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ))
        ]);
  }
}




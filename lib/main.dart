import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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
                //true
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

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Expanded(
          child:
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Welcome Onboard!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      Expanded(
          flex: 2,
          child:
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'Please enter your details to continue',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
              Expanded(
                //flex: 2,
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child:
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                ),
                validator: (value) {
                  // if (value.isEmpty) {
                  //   return 'Please enter your password';
                  // }
                  return null;
                },
              ),
        ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text('Sign Up'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform sign-up action
                    String name = _nameController.text;
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    print('Name: $name\nEmail: $email\nPassword: $password');
                  }
                },
              ),
              Expanded(
                child: Row(
                  children: [
                    Text('Already have an account?',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.7,
                    ),),
                    TextButton(onPressed: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BillTrackerPage()));
                        },
                        child:
                        Text('Log in here',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.7
                        ),)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BillTrackerPage extends StatefulWidget {
  @override
  _BillTrackerPageState createState() => _BillTrackerPageState();
}

class _BillTrackerPageState extends State<BillTrackerPage> {
  String _userName = "Sriram V"; // replace with user's name
  String _userImageURL =
      "https://example.com/user-image.png"; // replace with user's image URL

  List<charts.Series<Expense, DateTime>> _expenseData = [
    // replace with your own expense data
    charts.Series<Expense, DateTime>(
      id: 'Expenses',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (Expense expense, _) => expense.date,
      measureFn: (Expense expense, _) => expense.amount,
      data: [
        Expense(DateTime(2023, 3, 22), 25.0),
        Expense(DateTime(2023, 3, 23), 30.0),
        Expense(DateTime(2023, 3, 24), 20.0),
        Expense(DateTime(2023, 3, 25), 40.0),
        Expense(DateTime(2023, 3, 26), 15.0),
        Expense(DateTime(2023, 3, 27), 10.0),
        Expense(DateTime(2023, 3, 28), 35.0),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bill Tracker"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(_userImageURL),
          ),
          SizedBox(height: 10.0),
          Text(
            _userName,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: charts.TimeSeriesChart(
                _expenseData,
                animate: true,
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  tickProviderSpec:
                  const charts.BasicNumericTickProviderSpec(
                    desiredTickCount: 5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class Expense {
  final DateTime date;
  final double amount;

  Expense(this.date, this.amount);
}


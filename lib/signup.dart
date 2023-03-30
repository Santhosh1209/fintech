import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'bill_tracker.dart';
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
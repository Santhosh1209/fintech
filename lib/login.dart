import 'dart:convert';
import 'package:fintech/signup.dart';
import 'package:http/http.dart' as http;
import 'package:fintech/navigation.dart';
import 'package:flutter/material.dart';
import 'forgot_passwd.dart';
import 'package:url_launcher/url_launcher.dart';
import 'loan_intropage.dart';
import 'package:google_sign_in/google_sign_in.dart';

final googleSignIn = GoogleSignIn();
String email = "";
String password = "";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Welcome Back!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Empowering Your Finances, One Secure Login at a Time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0), // Add this line
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    height : 225,
                    child: Image(
                    image: AssetImage('images/undraw_transfer_money_re_6o1h.png'),
                ),
                  )
                ),
                SizedBox(height: 30.0), // Add this line
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Enter your details to log in',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0), // Add this line
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email ID';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    email = value; // Update the email variable
                  },
                ),
                SizedBox(height: 20.0), // Add this line
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    // if (value.isEmpty) {
                    // return 'Please enter your password';
                    // }
                    return null;
                  },
                  onChanged: (value) {
                    password = value; // Update the password variable
                  },
                ),
                SizedBox(height: 20.0), // Add this line
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ElevatedButton(
                onPressed: () async {
          setState(() {
          _isLoading = true;
          });
          await loginUser();
          Navigator.push(context, MaterialPageRoute(builder: (context) => NavigationScreen()));
          setState(() {
          _isLoading = false;
          });
          },
            child: _isLoading ? CircularProgressIndicator() : Text(
              'Log in Here',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 14.7,
              ),
            ),
          ),
          Text("  "),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.7,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// backend integration
Future<void> loginUser() async {
  print("Vanakam");
  var url = Uri.parse('https://fintech-rfnl.onrender.com/api/user/login');
  var headers = {'Content-Type': 'application/json'};

  var payload = {'email': email, 'password': password};

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
      var accessToken = data['token'];
      await StoreAccessToken(accessToken);
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
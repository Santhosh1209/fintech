import 'package:fintech/network/NetworkApi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'bill_tracker.dart';
import 'loan_fillup.dart';
import 'model/user_data.dart';
import 'account.dart';
import 'navigation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

final myCousin = GetIt.instance<ApiService>();
String name = "";
String email = "";
String password = "";


Future<void> StoreAccessToken(accessToken) async {
  final storage = FlutterSecureStorage();
  String key = 'access_token';
  await storage.write(key: key, value: accessToken);
  String? chumma = await storage.read(key: key);
  print(accessToken);
  print(chumma);
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late List<User>? _userModel = [];

  void _getData() async {
    _userModel = (await myCousin.getUsers())!;
    Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.lightBlueAccent,
                        Colors.blueAccent,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Welcome Onboard!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'Please enter your details to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child:
                TextFormField(
                  controller: _nameController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                  ),
                  validator: (value) {
                    // if (value.isEmpty) {
                    //   return 'Please enter your password';
                    // }
                    return null;
                  },
                ),
              ),
              Expanded(
                child:
                TextFormField(
                  controller: _emailController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                  ),
                  validator: (value) {
                    // if (value.isEmpty) {
                    //   return 'Please enter your password';
                    // }
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
                    name = _nameController.text;
                    email = _emailController.text;
                    password = _passwordController.text;
                    print('Name: $name\nEmail: $email\nPassword: $password');
                    postData();
                  }
                },
              ),
              Expanded(
                child: Row(
                  children: [
                    Text('Already have an account?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NavigationScreen()),
                        );
                      },
                      child: Text(
                        'Log in here',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
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

// backedn integration
void postData() async {
  print("Vanakam");
  var url = Uri.parse('https://fintech-rfnl.onrender.com/api/user/');
  var headers = {'Content-Type': 'application/json'};

  var payload = {'userName': name, 'email': email, 'password': password};

  try {
    print("Vanakam2");
    var response = await http.post(
      url,
      headers: headers,
      body: json.encode(payload),
    );

    if (response.statusCode == 201) {
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
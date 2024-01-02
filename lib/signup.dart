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
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  'Welcome Onboard!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Image(
                  image: AssetImage('images/undraw_Finance_re_gnv2.png'),
                ),
                Text(
                  'Please enter your details to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _nameController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
                SizedBox(height: 20),
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
                    return null;
                  },
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold),),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      name = _nameController.text;
                      email = _emailController.text;
                      password = _passwordController.text;
                      print('Name: $name\nEmail: $email\nPassword: $password');
                      postData();
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>
                              NavigationScreen()));
                    }
                  },
                ),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                      ),
                    ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// backend integration
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
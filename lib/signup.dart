import 'package:fintech/network/NetworkApi.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'bill_tracker.dart';
import 'chumma.dart';
import 'model/user_data.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}
final myCousin = GetIt.instance<ApiService>();

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
  void initState() {
    super.initState();
    _getData();
  }

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
                      // 'Please enter your details to continue\n${_userModel![0].phone}',
                      'Please enter your details to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
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
                        const Text('Log in here',
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
import 'package:fintech/navigation.dart';
import 'package:flutter/material.dart';
import 'forgot_passwd.dart';
import 'package:url_launcher/url_launcher.dart';
import 'loan_intropage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
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
                ),
                Expanded(
                  flex: 3,
                  child: Image(
                    image: AssetImage('images/undraw_transfer_money_re_6o1h.png'),
                  ),
                ),
                Expanded(
                  child: Padding(
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
                        return 'Please enter your email ID';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
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
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => NavigationScreen()));
                        },
                        child: Text(
                          'Log in Here',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 14.7,
                          ),
                        ),
                      ),
                      Text("    "),
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
                ),
                Expanded(
                    child: Row
                      (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        TextButton(
                          onPressed: ()
                    {
                      //
                    },
                          child: Image(
                              image: AssetImage('images/google.png'),
                          height: 40,
                              width: 30,),
                        ),
                        TextButton(
                          onPressed: ()
                          {
                            //
                          },
                          child: Image(
                              image: AssetImage('images/facebook-app-symbol.png'),
                          height: 40,
                              width: 30,),
                        ),
                        TextButton(
                          onPressed: ()
                          {
                            //
                          },
                          child: Image(
                              image: AssetImage('images/twitter-sign.png'),
                          height: 40,
                              width: 30,),
                        ),
                      ],
                    )
                )
              ],
          ),
        ),
    )
    );
  }
}

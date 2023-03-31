import 'package:fintech/bill_tracker.dart';
import 'package:flutter/material.dart';
import 'forgot_passwd.dart';
import 'account.dart';
import 'package:url_launcher/url_launcher.dart';
import 'loan_intropage.dart';
import 'loan_fillup.dart';
class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding
        (padding: EdgeInsets.all(16.0),
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
              'Welcome Back!',
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
                        'Enter your details to log in',
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
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
            onPressed: ()
                {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountPage()));
                },
          child:
                Text('Log in Here',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.7
                  ),
                )
            ),
            TextButton(onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
            },
                child:
                Text('Forgot Password',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 14.7
                  ),)
            )
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
                          async {
                            const url = 'https://twitter.com/login';
                            final uri = Uri.parse(url);
                            if (await canLaunchUrl(Uri())) {
                          await launchUrl(Uri());
                          } else {
                          throw 'Could not launch $url';
                          }
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

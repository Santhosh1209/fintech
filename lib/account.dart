import 'package:flutter/material.dart';

class accountPage extends StatefulWidget {
  const accountPage({Key? key}) : super(key: key);

  @override
  State<accountPage> createState() => _accountPageState();
}

class _accountPageState extends State<accountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar
        (
        title: Text("My Account"),
        centerTitle: true,
      ),
      body: Column
        (
        children: [
          Row(
            children: [
              CircleAvatar(
               radius: 50.0,
                backgroundColor: Colors.blue[900],
              ),
              Text(
                'SRIRAM V',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'
                ),
              ),
            ],
          ),
          Container()
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'loan_fillup.dart';

class LoanTrackingPage extends StatefulWidget {
  const LoanTrackingPage({Key? key}) : super(key: key);

  @override
  _LoanTrackingPageState createState() => _LoanTrackingPageState();
}

class _LoanTrackingPageState extends State<LoanTrackingPage> {
  // Add your state variables here
  bool _isEditing = false;
  List<String> _loanNames = [    "Loan 1",    "Loan 2",    "Loan 3",  ];
  List<String> _amount = ['500000','80000','175000'];
  //List<String> _percentage = ['60%','75%','85%'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Tracking"),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _loanNames.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(_loanNames[index]),
                  trailing: _isEditing
                      ? IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _loanNames.removeAt(index);
                      });
                    },
                  )
                      : IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      // Add your logic here for what should happen when a loan is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoanDetailsPage(
                            loanName: _loanNames[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child : Row(
                    children: [
                      Text ('Total Amount : '),
                      Text(_amount[index]),
                      //Text(_percentage[index])
                    ],
                  )
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => newLoanPage()));
          },
      ),
    );
  }
}

class LoanDetailsPage extends StatelessWidget {
  final String loanName;

  const LoanDetailsPage({Key? key, required this.loanName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loanName),
      ),
      body: Center(
        child: Text("Loan details for $loanName"),
      ),
    );
  }
}

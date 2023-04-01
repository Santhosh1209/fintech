import 'package:flutter/material.dart';
import 'loan_intropage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Rails',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // initialize a index
  int _selectedIndex = 0;

  // create a list of pages
  final List<Widget> _pages = [
    AccountPage(),
    BillsPage(),
    LoansPage(),
    FAQsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rail"),
        centerTitle: true,
      ),
      body: Row(
        children: <Widget>[
          // create a navigation rail
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.selected,
            backgroundColor: Colors.green,
            destinations: const <NavigationRailDestination>[
              // navigation destinations
              NavigationRailDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person),
                label: Text('Account'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.receipt),
                selectedIcon: Icon(Icons.receipt),
                label: Text('Bills'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.currency_exchange),
                selectedIcon: Icon(Icons.currency_exchange),
                label: Text('Loans'),

              ),
              NavigationRailDestination(
                icon: Icon(Icons.help),
                selectedIcon: Icon(Icons.help),
                label: Text('FAQs'),
              ),
            ],
            selectedIconTheme: IconThemeData(color: Colors.white),
            unselectedIconTheme: IconThemeData(color: Colors.black),
            selectedLabelTextStyle: TextStyle(color: Colors.white),
          ),
          const VerticalDivider(thickness: 1, width: 2),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed:()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoanTrackingPage()));
    },
        child: Text('Loan')
    );
  }
}

class BillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed:()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoanTrackingPage()));
    },
        child: Text('Loan')
    );
  }
}

class LoansPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed:()
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoanTrackingPage()));
    },
        child: Text('loan')
    );
  }
}

class FAQsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed:()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoanTrackingPage()));
        },
        child: Text('loan')
    );
  }
}


import 'package:fintech/account.dart';
import 'package:fintech/bill_tracker.dart';
import 'package:fintech/loan_intropage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const NavigationScreen());

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationState()
    );
  }
}

class NavigationState extends StatefulWidget {
  const NavigationState({super.key});

  @override
  State<NavigationState> createState() => _NavigationStateState();
}

class _NavigationStateState extends State<NavigationState> {
  int currentPageIndex = 0;

  // create a list of pages
  final List<Widget> _pages = [
    MyAccountPage(),
    BillTrackerPage(),
    LoanTrackingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person),
            label: "Account",
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt),
            selectedIcon: Icon(Icons.receipt),
            label: "Bills",
          ),
          NavigationDestination(
            icon: Icon(Icons.currency_exchange),
            selectedIcon: Icon(Icons.currency_exchange),
            label: "Loans"
          ),
        ],
      ),
      body: _pages[currentPageIndex],
    );
  }
}

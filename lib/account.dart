import 'package:flutter/material.dart';
import 'login.dart';
import 'network/help_and_support.dart';

class MyAccountPage extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  // Function to show the logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog() async {
    // Variable to track whether the logout process is in progress
    bool isLoggingOut = false;

    // Function to perform logout actions
    Future<void> _performLogout() async {
      // Simulate a delay (replace with actual logout logic)
      await Future.delayed(Duration(seconds: 2));

      // Perform logout actions
      Navigator.popUntil(context, ModalRoute.withName('/'));
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation', style: TextStyle(fontSize: 20)),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ButtonStyle(
                alignment: AlignmentDirectional.centerStart,
              ),
            ),
            Spacer(), // Add Spacer to push Logout button to the right
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                if (!isLoggingOut) {
                  // Set the flag to indicate that logout is in progress
                  isLoggingOut = true;

                  // Close the dialog
                  Navigator.of(context).pop();

                  // Show a CircularProgressIndicator
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );

                  // Perform logout actions
                  _performLogout().then((_) {
                    // Close the CircularProgressIndicator dialog
                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50'),
          ),
          SizedBox(height: 20),
          Text(
            'Sharad',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 40),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Edit Profile page
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to Settings page
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Help & Support'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelpAndSupportPage()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log out'),
            onTap: () {
              // Show the logout confirmation dialog
              _showLogoutConfirmationDialog();
            },
          ),
        ],
      ),
    );
  }
}

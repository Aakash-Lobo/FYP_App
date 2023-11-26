import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/student_profile.dart';
import 'package:flutter_application_1/Roles/Student/student_home.dart';

class StudentLibraryPage extends StatelessWidget {
  final String username;

  StudentLibraryPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Library Page'),
      ),
      drawer: CustomSideNavigationBar(username: username),
      body: Center(
        child: Text('Welcome to the Library Page, $username!'),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(username: username),
    );
  }
}

class CustomSideNavigationBar extends StatelessWidget {
  final String username;

  CustomSideNavigationBar({required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'View Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              _showExitConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit Confirmation'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentHomePage(username: username),
                  ),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final String username;

  CustomBottomNavigationBar({required this.username});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pages),
          label: 'Plain Page',
        ),
      ],
      onTap: (index) {
        _navigateToPage(index, context);
      },
    );
  }

  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        // Navigate to Home/Dashboard Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StudentLibraryPage(username: username),
          ),
        );
        break;
      case 1:
        // Navigate to Plain Page
        // Replace PlainPage with the actual page class
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PlainPage(username: username),
          ),
        );
        break;
    }
  }
}

class PlainPage extends StatelessWidget {
  final String username;

  PlainPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plain Page'),
      ),
      body: Center(
        child: Text('Welcome to the Plain Page, $username!'),
      ),
    );
  }
}

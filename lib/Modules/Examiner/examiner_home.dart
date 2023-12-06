import 'package:flutter/material.dart';
import 'package:flutter_application_1/Credentials/logout.dart';
import 'package:flutter_application_1/Modules/Examiner/AddExamPage.dart';
import 'package:flutter_application_1/Modules/Examiner/AddExamineePage.dart';
import 'package:flutter_application_1/Modules/Examiner/ViewExamFeedbackPage.dart';
import 'package:flutter_application_1/Modules/Examiner/ViewExamPage.dart';
import 'package:flutter_application_1/Modules/Examiner/ViewExamineePage.dart';
import 'package:flutter_application_1/Modules/Examiner/ViewRankingPage.dart';
import 'package:flutter_application_1/Modules/Examiner/ViewReportPage.dart';
import 'package:flutter_application_1/contact.dart';

class ExaminerHomePage extends StatefulWidget {
  final String username;

  ExaminerHomePage({required this.username});

  @override
  _ExaminerHomePageState createState() => _ExaminerHomePageState();
}

class _ExaminerHomePageState extends State<ExaminerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Librarian Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, ${widget.username}!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add librarian home page content here
          ],
        ),
      ),
      drawer: CustomSideNavigationBar(
        username: widget.username,
        onLogout: (bool isLoggingOut) {
          if (isLoggingOut) {
            // Log the user out and navigate to the login page
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
  }
}

class CustomSideNavigationBar extends StatelessWidget {
  final String username;
  final Function(bool) onLogout;

  CustomSideNavigationBar({
    required this.username,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Your Name'),
            accountEmail: Text(username),
            currentAccountPicture: CircleAvatar(
                // Add your profile picture here
                ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('View Exam'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewExamPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Exam'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExamPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('View Examinee'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewExamineePage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_returned_outlined),
            title: Text('Add Examinee'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddExamineePage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Ranking'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewRankingPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Report'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewReportPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Feedback'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewExamFeedbackPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return LogoutDialog(onLogout: onLogout);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../admin_home.dart';
import '../admin_profile.dart';
import 'AddStudentPage.dart';
import 'ViewStudentsPage.dart';
import 'AssignStudentSubjectsPage.dart';
import 'StudentAttendancePage.dart';
import 'StudentFeePage.dart';

class AdminStudent extends StatelessWidget {
  final String username;

  AdminStudent({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 16),
            ),
            // Add your dashboard content here
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AdminStudent.dart (dashboard)
              },
            ),
            ListTile(
              title: Text('Add Student'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AddStudentPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStudentPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('View Students'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to ViewStudentsPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewStudentsPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Assign Subjects'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AssignSubjectsPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AssignSubjectsPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Student Attendance'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to StudentAttendancePage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentAttendancePage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Student Fee'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to StudentFeePage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentFeePage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Exit'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminHomePage(username: username),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

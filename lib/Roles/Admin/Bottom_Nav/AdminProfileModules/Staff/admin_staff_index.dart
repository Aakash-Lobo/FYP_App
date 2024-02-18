import 'package:flutter/material.dart';
import '../../../admin_home.dart';
import '../admin_profile.dart';
import 'AddStaffPage.dart';
import 'StaffLeavePage.dart';
import 'StaffSalaryPage.dart';
import 'ViewStaffPage.dart';

class AdminStaff extends StatelessWidget {
  final String username;

  AdminStaff({required this.username});

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
              title: Text('Add Staff'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AddStudentPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddStaffPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('View Staff'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to ViewStudentsPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewStaffPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Staff Salary'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AssignSubjectsPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StaffSalaryPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Staff Leave'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AssignSubjectsPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StaffLeavePage(username: username),
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

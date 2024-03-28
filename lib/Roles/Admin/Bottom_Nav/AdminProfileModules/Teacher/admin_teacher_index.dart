import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/AddTeacherPage.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/AddTeacherSalaryPage.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/AssignTeacherSubjectsPage.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/ViewTeacherLeavePage.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/ViewTeacherPage.dart';
import '../../../admin_home.dart';
import '../admin_profile.dart';

class AdminTeacher extends StatelessWidget {
  final String username;

  AdminTeacher({required this.username});

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
              title: Text('Add Teacher'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AddStudentPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTeacherPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('View Teachers'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to ViewStudentsPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewTeachersPage(username: username),
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
                        AssignTeacherSubjectsPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Teacher Leave'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AssignSubjectsPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewTeacherLeavePage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Teacher Salary'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AssignSubjectsPage.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddTeacherSalaryPage(username: username),
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

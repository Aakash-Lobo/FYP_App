import 'package:flutter/material.dart';

import '../../../admin_home.dart';
import 'AdminAddCourse.dart';
import 'AdminAddSubjects.dart';
import 'AdminViewCourse.dart';
import 'AdminViewSubjects.dart';

class AdminCourse extends StatelessWidget {
  final String username;

  AdminCourse({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Course Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin Course Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 16),
            ),
            // Add your admin course information here
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
                // Navigator.push to AdminCourse.dart (dashboard)
              },
            ),
            ListTile(
              title: Text('View Course'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AdminViewCourse.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminViewCourse(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Add Course'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AdminAddCourse.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAddCourse(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('View Subjects'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AdminViewSubjects.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminViewSubjects(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Add Subjects'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AdminAddSubjects.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminAddSubjects(username: username),
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

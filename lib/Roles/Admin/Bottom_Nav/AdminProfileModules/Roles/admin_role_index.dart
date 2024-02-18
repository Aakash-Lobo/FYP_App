import 'package:flutter/material.dart';

import '../../../admin_home.dart';
import 'AccessRolesPage.dart';
import 'AddRolesPage.dart';
import 'ViewRolesPage.dart';

class AdminRole extends StatelessWidget {
  final String username;

  AdminRole({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Role Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin Role Information',
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
              title: Text('View Roles'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AdminViewCourse.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewRolesPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Add Roles'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AdminAddCourse.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddRolesPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Access Roles'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigator.push to AdminViewSubjects.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccessRolesPage(username: username),
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

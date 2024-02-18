import 'package:flutter/material.dart';

import '../../../admin_home.dart';
import 'AddNoticePage.dart';
import 'ViewNoticePage.dart';

class AdminNotices extends StatelessWidget {
  final String username;

  AdminNotices({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Notice Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin Notice Information',
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
              title: Text('View Notices'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewNoticePage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Add Notices'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNoticePage(username: username),
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

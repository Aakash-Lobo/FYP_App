import 'package:flutter/material.dart';

import '../../../admin_home.dart';

class AdminTimeTable extends StatelessWidget {
  final String username;

  AdminTimeTable({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Time Table Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin Time Table Information',
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

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Student/SMS/student_index.dart';

class ProfilePage extends StatelessWidget {
  final String username;

  ProfilePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'User Profile Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 16),
            ),
            // Add your user profile information here
            SizedBox(
                height: 20), // Add spacing between profile info and the card

            // Card with profile icon
            GestureDetector(
              onTap: () {
                // Navigate to the StudentDashboardPage with the username
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentDashboardPage(username: username),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                child: Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.account_circle,
                    size: 64,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

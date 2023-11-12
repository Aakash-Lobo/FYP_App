import 'package:flutter/material.dart';
import 'package:flutter_application_1/admin/Bottom_Nav/profile/student/admin_student_index.dart';
import 'package:flutter_application_1/admin/Bottom_Nav/profile/teacher/admin_teacher_index.dart';
import 'course/admin_course_index.dart';
// Import the AdminTeacher class

class AdminProfilePage extends StatelessWidget {
  final String username;

  AdminProfilePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Admin Profile Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Username: $username',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminStudent(username: username),
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

            SizedBox(height: 20),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminCourse(username: username),
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
                    Icons.book,
                    size: 64,
                    color: Colors.green,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // New card for AdminTeacher
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminTeacher(username: username),
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
                    Icons.school,
                    size: 64,
                    color: Colors.orange,
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

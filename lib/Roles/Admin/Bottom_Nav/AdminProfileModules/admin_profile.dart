import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Complaint/admin_complaint.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Feedback/admin_feedback.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Notices/admin_notice.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Roles/admin_role_index.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Staff/admin_staff_index.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Student/admin_student_index.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/admin_teacher_index.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Timetable/admin_timetable.dart';
import 'Course/admin_course_index.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminStaff(username: username),
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
                        Icons.person_2,
                        size: 64,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminRole(username: username),
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
                        Icons.person_3,
                        size: 64,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AdminTimeTable(username: username),
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
                        Icons.timelapse,
                        size: 64,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminNotices(username: username),
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
                        Icons.notifications_none,
                        size: 64,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminFeedback(username: username),
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
                        Icons.feed,
                        size: 64,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminComplaint(username: username),
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
                    Icons.comment,
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

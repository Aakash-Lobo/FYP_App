import 'package:flutter/material.dart';

import 'package:flutter_application_1/Roles/Common/Cafe/StudentCafePage.dart';
import 'package:flutter_application_1/Roles/Common/Counselling/CommonCounselPage.dart';
import 'package:flutter_application_1/Roles/Common/Health/CommonHealthPage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Course/StudentCoursesPage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Exam/StudentExaminationPage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Placement/StudentPlacementPage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Result/StudentResultPage.dart';
import 'package:flutter_application_1/Roles/Student/SMS/student_index.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Fees/StudentFeesPage.dart';

import '../../Common/Library/CommonLibraryPage.dart';
import '../../Common/Merch/StudentMerchPage.dart';
import 'StudentProfileModules/Hostel/StudentHostelPage.dart';

class StudentProfilePage extends StatelessWidget {
  final String username;

  StudentProfilePage({required this.username});

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
            SizedBox(height: 20),

            // Section with two rows and four squares in each row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Square 1 - Attendance
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         StudentAttendancePage(username: username),
                    //   ),
                    // );
                  },
                  child: buildSquare("Attendance", Icons.calendar_today),
                ),

                // Square 2 - Examination
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentExaminationPage(username: username),
                      ),
                    );
                  },
                  child: buildSquare("Examination", Icons.assignment),
                ),

                // Square 3 - Placement
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentPlacementPage(username: username),
                      ),
                    );
                  },
                  child: buildSquare("Placement", Icons.work),
                ),

                // Square 4 - Courses
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentCoursesPage(username: username),
                      ),
                    );
                  },
                  child: buildSquare("Notes", Icons.menu_book),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Second Row with four squares
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Square 5 - Fees
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentFeesPage(username: username),
                      ),
                    );
                  },
                  child: buildSquare("Fees", Icons.attach_money),
                ),

                // Square 6 - Result
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentResultPage(username: username),
                      ),
                    );
                  },
                  child: buildSquare("Result", Icons.poll),
                ),

                // Square 7 - Counselling
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CommonCounselPage(username: username),
                      ),
                    );
                  },
                  child: buildSquare("Counselling", Icons.group),
                ),

                // Square 8 - Feedback
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         StudentFeePage(username: username),
                    //   ),
                    // );
                  },
                  child: buildSquare("Feedback", Icons.feedback),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Additional section with two columns and four rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Rectangle 1 - Library
                GestureDetector(
                  onTap: () {
                    // Navigate to the LibraryPage with the username
                    // (You need to replace LibraryPage with the actual page class)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CommonLibraryPage(username: username),
                      ),
                    );
                  },
                  child: buildRectangle("Library"),
                ),

                // Rectangle 2 - Merch
                GestureDetector(
                  onTap: () {
                    // Navigate to the MerchPage with the username
                    // (You need to replace MerchPage with the actual page class)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentMerchPage(username: username),
                      ),
                    );
                  },
                  child: buildRectangle("Merch"),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Fourth Row with two rectangles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Rectangle 3 - Cafe
                GestureDetector(
                  onTap: () {
                    // Navigate to the CafePage with the username
                    // (You need to replace CafePage with the actual page class)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentCafePage(username: username),
                      ),
                    );
                  },
                  child: buildRectangle("Cafe"),
                ),

                // Rectangle 4 - Health
                GestureDetector(
                  onTap: () {
                    // Navigate to the HealthPage with the username

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CommonHealthPage(username: username),
                      ),
                    );
                  },
                  child: buildRectangle("Health"),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Fifth Row with two rectangles
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Rectangle 5 - Transport
                GestureDetector(
                  onTap: () {
                    // Navigate to the TransportPage with the username
                    // (You need to replace TransportPage with the actual page class)
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => TransportPage(username: username),
                    //   ),
                    // );
                  },
                  child: buildRectangle("Transport"),
                ),

                // Rectangle 6 - Hostel
                GestureDetector(
                  onTap: () {
                    // Navigate to the HostelPage with the username
                    // (You need to replace HostelPage with the actual page class)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StudentHostelPage(username: username),
                      ),
                    );
                  },
                  child: buildRectangle("Hostel"),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Sixth Row with two rectangles
          ],
        ),
      ),
    );
  }

  // Function to build a square with an icon and text
  Widget buildSquare(String text, IconData iconData) {
    return Card(
      elevation: 3,
      child: Container(
        width: 80,
        height: 80,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a rectangle with text
  Widget buildRectangle(String text) {
    return Card(
      elevation: 3,
      child: Container(
        width: 150,
        height: 80,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

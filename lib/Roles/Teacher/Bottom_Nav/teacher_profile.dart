import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Common/Cafe/StudentCafePage.dart';
import 'package:flutter_application_1/Roles/Common/Counselling/StudentCounsellingPage.dart';

import '../../Common/Library/StudentLibraryPage.dart';
import '../../Common/Merch/StudentMerchPage.dart';

class TeacherProfilePage extends StatelessWidget {
  final String username;

  TeacherProfilePage({required this.username});

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
                  child: buildSquare("Salary", Icons.calendar_today),
                ),

                // Square 2 - Examination
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         StudentExaminationPage(username: username),
                    //   ),
                    // );
                  },
                  child: buildSquare("Exam", Icons.assignment),
                ),

                // Square 3 - Placement
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         StudentPlacementPage(username: username),
                    //   ),
                    // );
                  },
                  child: buildSquare("Notes", Icons.work),
                ),

                // Square 4 - Courses
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         StudentCoursesPage(username: username),
                    //   ),
                    // );
                  },
                  child: buildSquare("Result", Icons.menu_book),
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         StudentFeePage(username: username),
                    //   ),
                    // );
                  },
                  child: buildSquare("Leave", Icons.attach_money),
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
                            StudentLibraryPage(username: username),
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
                    // (You need to replace HealthPage with the actual page class)
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HealthPage(username: username),
                    //   ),
                    // );
                  },
                  child: buildRectangle("Health"),
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

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Examiner/examiner_home.dart';
import 'package:flutter_application_1/Roles/Common/Cafe/StudentCafePage.dart';
import 'package:flutter_application_1/Roles/Common/Counselling/CommonCounselPage.dart';
import 'package:flutter_application_1/Roles/Common/Health/CommonHealthPage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Hostel/StudentHostelPage.dart';
import 'package:flutter_application_1/Roles/Teacher/Bottom_Nav/TeacherProfileModules/Attendance/AttendanceStudentPage.dart';
import 'package:flutter_application_1/Roles/Teacher/Bottom_Nav/TeacherProfileModules/Course/TeacherCoursePage.dart';
import 'package:flutter_application_1/Roles/Teacher/Bottom_Nav/TeacherProfileModules/Feedback/TeacherFeedbackPage.dart';
import 'package:flutter_application_1/Roles/Teacher/Bottom_Nav/TeacherProfileModules/Leave/TeacherLeavePage.dart';
import 'package:flutter_application_1/Roles/Teacher/Bottom_Nav/TeacherProfileModules/Notes/TeacherNotesPage.dart';
import 'package:flutter_application_1/Roles/Teacher/Bottom_Nav/TeacherProfileModules/Result/TeacherResultPage.dart';
import 'package:flutter_application_1/Roles/Teacher/Bottom_Nav/TeacherProfileModules/Salary/TeacherSalaryPage.dart';
import '../../Common/Library/CommonLibraryPage.dart';
import '../../Common/Merch/StudentMerchPage.dart';

class TeacherProfilePage extends StatelessWidget {
  final String username;

  TeacherProfilePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Modules',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Attendance page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TeacherCoursePage(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.event_note,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Course',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Examination page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ExaminerHomePage(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.assignment,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Exam',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TeacherNotesPage(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.work,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          'Notes',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
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
                          child: CustomSquare(
                            icon: Icons.school,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          'Counselling',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TeacherSalaryPage(username: "username"),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.attach_money,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Text(
                          'Salary',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Result page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TeacherResultPage(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.assessment,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          'Result',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigate to the Counselling page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TeacherLeavePage(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.chat,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          'Leave',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TeacherFeedbackPage(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.feedback,
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          'Feedback',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Library page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CommonLibraryPage(username: username),
                          ),
                        );
                      },
                      child: CustomRectangularCard(
                        imageUrl: 'assets/CommonBanner/library.jpeg',
                        title: 'Library',
                        shadowColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Cafe page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentCafePage(username: username),
                          ),
                        );
                      },
                      child: CustomRectangularCard(
                        imageUrl: 'assets/CommonBanner/cafe.jpeg',
                        title: 'Cafe',
                        shadowColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Merchandise page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentMerchPage(username: username),
                          ),
                        );
                      },
                      child: CustomRectangularCard(
                        imageUrl: 'assets/CommonBanner/merch.jpeg',
                        title: 'Merchandise',
                        shadowColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Library page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CommonLibraryPage(username: username),
                          ),
                        );
                      },
                      child: CustomRectangularCard(
                        imageUrl: 'assets/CommonBanner/health.jpeg',
                        title: 'Health',
                        shadowColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         CommonHealthPage(username: username),
                        //   ),
                        // );
                      },
                      child: CustomRectangularCard(
                        imageUrl: 'assets/CommonBanner/transport.jpeg',
                        title: 'Transportation',
                        shadowColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StudentHostelPage(username: username),
                          ),
                        );
                      },
                      child: CustomRectangularCard(
                        imageUrl: 'assets/CommonBanner/hostel.jpeg',
                        title: 'Hostel',
                        shadowColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSquare extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CustomSquare({
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 1), // Thin blue border
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            // spreadRadius: 2,
            // blurRadius: 5,
            // offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, size: 30, color: Colors.white),
      ),
    );
  }
}

class CustomRectangularCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color? shadowColor;

  const CustomRectangularCard({
    required this.imageUrl,
    required this.title,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

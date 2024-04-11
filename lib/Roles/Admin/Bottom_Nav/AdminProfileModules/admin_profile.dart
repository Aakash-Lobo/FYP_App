import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Chef/chef_home.dart';
import 'package:flutter_application_1/Modules/Doctor/doctor_home.dart';
import 'package:flutter_application_1/Modules/Librarian/librarian_home.dart';
import 'package:flutter_application_1/Modules/Warden/warden_home.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Complaint/admin_complaint.dart';
// import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Feedback/admin_feedback.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Notices/admin_notice.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Roles/admin_role_index.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Staff/admin_staff_index.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Student/admin_student_index.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Teacher/admin_teacher_index.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Timetable/admin_timetable.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Course/admin_course_index.dart';

class AdminProfilePage extends StatelessWidget {
  final String username;

  AdminProfilePage({required this.username});

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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminStudent(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.school,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          'Student',
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
                                    AdminTeacher(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.person,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Teacher',
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
                            // Navigate to the Placement page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminStaff(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.group,
                            color: Colors.orange,
                          ),
                        ),
                        Text(
                          'Staff',
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
                            // Navigate to the Courses page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminCourse(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.library_books,
                            color: Colors.purple,
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
                            // Navigate to the Fees page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AdminRole(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.group_work,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Text(
                          'Roles',
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
                                    AdminNotices(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.notification_important,
                            color: Colors.deepPurple,
                          ),
                        ),
                        Text(
                          'Notice',
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
                                    AdminTimeTable(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.access_time,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          'Time',
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
                                    AdminComplaint(username: username),
                              ),
                            );
                          },
                          child: CustomSquare(
                            icon: Icons.feedback,
                            color: Colors.pink,
                          ),
                        ),
                        Text(
                          'Complaint',
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
                                LibrarianHomePage(username: username),
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
                                ChefHomePage(username: username),
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         Merch(username: username),
                        //   ),
                        // );
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
                                DoctorHomePage(username: username),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                WardenHomePage(username: username),
                          ),
                        );
                      },
                      child: CustomRectangularCard(
                        imageUrl: 'assets/CommonBanner/hostel.jpeg',
                        title: 'Hostel',
                        shadowColor: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Library page
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         DoctorHomePage(username: username),
                        //   ),
                        // );
                      },
                      child: CustomRectangularCard(
                        imageUrl: 'assets/CommonBanner/transport.jpeg',
                        title: 'Counselling',
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

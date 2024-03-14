import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Doctor/doctor_home.dart';
import 'package:flutter_application_1/Modules/Warden/warden_home.dart';
import 'package:flutter_application_1/Modules/Chef/chef_home.dart';
import 'package:flutter_application_1/Modules/Examiner/examiner_home.dart';
import 'package:flutter_application_1/Modules/Placement/placement_home.dart';
import 'package:flutter_application_1/Roles/Admin/admin_home.dart';
import 'package:flutter_application_1/Roles/Staff/staff_home.dart';
import 'package:flutter_application_1/Roles/Teacher/teacher_home.dart';
import 'package:flutter_application_1/Roles/student/student_home.dart';
import 'Credentials/login.dart';
import 'Modules/Librarian/librarian_home.dart'; // Import the admin home page

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => LoginPage(),
        '/student_home': (context) =>
            StudentHomePage(username: 'your_username'),
        '/teacher_home': (context) =>
            TeacherHomePage(username: 'your_username'),
        '/staff_home': (context) => StaffHomePage(username: 'your_username'),
        '/admin_home': (context) => AdminHomePage(username: 'your_username'),
        '/librarian_home': (context) =>
            LibrarianHomePage(username: 'your_username'),
        '/placement_home': (context) =>
            PlacementHomePage(username: 'your_username'),
        '/examiner_home': (context) =>
            ExaminerHomePage(username: 'your_username'),
        '/chef_home': (context) => ChefHomePage(username: 'your_username'),
        '/warden_home': (context) => WardenHomePage(username: 'your_username'),
        '/doctor_home': (context) => DoctorHomePage(username: 'your_username'),
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

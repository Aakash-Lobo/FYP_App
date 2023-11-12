import 'package:flutter/material.dart';

import 'package:flutter_application_1/Roles/Teacher/teacher_home.dart';
import 'package:flutter_application_1/Roles/student/student_home.dart';
import 'package:flutter_application_1/admin/admin_home.dart';

import 'Credentials/login.dart'; // Import the admin home page

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
        '/admin_home': (context) => AdminHomePage(username: 'your_username'),
        '/admin_home': (context) => AdminHomePage(
            username: 'your_username'), // Add route for admin home page
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

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Doctor/doctor_home.dart';
import 'package:flutter_application_1/Modules/Warden/warden_home.dart';
import 'package:flutter_application_1/Modules/Chef/chef_home.dart';
import 'package:flutter_application_1/Modules/Examiner/examiner_home.dart';
import 'package:flutter_application_1/Modules/Librarian/librarian_home.dart';
import 'package:flutter_application_1/Modules/Placement/placement_home.dart';
import 'package:flutter_application_1/Roles/Admin/admin_home.dart';
import 'package:flutter_application_1/Roles/student/student_home.dart';
import 'package:flutter_application_1/Roles/Teacher/teacher_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Roles/Staff/staff_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;
  String? emailError, passwordError;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    emailError = null;
    passwordError = null;
  }

  void resetErrorText() {
    setState(() {
      emailError = null;
      passwordError = null;
    });
  }

  bool validate() {
    resetErrorText();
    // RegExp emailExp = RegExp(
    //     r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
    //     );

    bool isValid = true;
    // if (email.isEmpty || !emailExp.hasMatch(email)) {
    //   setState(() {
    //     emailError = 'Email is invalid';
    //   });
    //   isValid = false;
    // }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Please enter a password';
      });
      isValid = false;
    }

    return isValid;
  }

  void loginPage() async {
    if (validate()) {
      final response = await http.post(
        Uri.parse('http://localhost/fyp/app/login.php'),
        body: {'username': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] != null) {
          String role = data['role'];
          String username = data['username'];

          if (role == 'student') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StudentHomePage(username: username),
              ),
            );
          } else if (role == 'teacher') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TeacherHomePage(username: username),
              ),
            );
          } else if (role == 'staff') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => StaffHomePage(username: username),
              ),
            );
          } else if (role == 'admin') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminHomePage(username: username),
              ),
            );
          } else if (role == 'librarian') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LibrarianHomePage(username: username),
              ),
            );
          } else if (role == 'placement') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PlacementHomePage(username: username),
              ),
            );
          } else if (role == 'examiner') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ExaminerHomePage(username: username),
              ),
            );
          } else if (role == 'doctor') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorHomePage(username: username),
              ),
            );
          } else if (role == 'chef') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChefHomePage(username: username),
              ),
            );
          } else if (role == 'warden') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WardenHomePage(username: username),
              ),
            );
          } else {
            // Handle other roles or scenarios
          }
        } else if (data['error'] != null) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Login Error"),
                content: Text("Invalid username or password."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Connection Error"),
              content: Text("Failed to connect to the server."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * .12),
            const Text(
              'Welcome,',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * .01),
            Text(
              'Sign in to continue!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black.withOpacity(.6),
              ),
            ),
            SizedBox(height: screenHeight * .12),
            InputField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              labelText: 'Email',
              errorText: emailError,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autoFocus: true,
            ),
            SizedBox(height: screenHeight * .025),
            InputField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              onSubmitted: (val) => loginPage(),
              labelText: 'Password',
              errorText: passwordError,
              obscureText: true,
              textInputAction: TextInputAction.next,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .075,
            ),
            FormButton(
              text: 'Log In',
              onPressed: loginPage,
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const InputField({
    required this.labelText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.autoFocus = false,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofocus: autoFocus,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const FormButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

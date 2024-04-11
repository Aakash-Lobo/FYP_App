import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Attendance/Semesters/semfive.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Attendance/Semesters/semfour.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Attendance/Semesters/semone.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Attendance/Semesters/semsix.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Attendance/Semesters/semthree.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Attendance/Semesters/semtwo.dart';

class StudentViewAttendancePage extends StatelessWidget {
  final String username;

  StudentViewAttendancePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Semesters',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SemestersGroup(semesters: [1, 2], username: username),
          Divider(),
          SemestersGroup(semesters: [3, 4], username: username),
          Divider(),
          SemestersGroup(semesters: [5, 6], username: username),
        ],
      ),
    );
  }
}

class SemestersGroup extends StatelessWidget {
  final List<int> semesters;
  final String username;

  SemestersGroup({required this.semesters, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: semesters.map((semester) {
        return SemesterTile(
          semester: semester,
          username: username,
        );
      }).toList(),
    );
  }
}

class SemesterTile extends StatelessWidget {
  final int semester;
  final String username;

  SemesterTile({required this.semester, required this.username});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Semester $semester',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        ListTile(
          title: Text(
            'View Semester $semester',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            switch (semester) {
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SemesterOneAttend(username: username),
                  ),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SemesterTwoAttend(username: username),
                  ),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterThreeAttend(username: username),
                  ),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterFourAttend(username: username),
                  ),
                );
                break;
              case 5:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterFiveAttend(username: username),
                  ),
                );
                break;
              case 6:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SemesterSixAttend(username: username),
                  ),
                );
                break;
            }
          },
        ),
      ],
    );
  }
}

class SemesterDetailsPage extends StatelessWidget {
  final int semester;

  SemesterDetailsPage({required this.semester});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Semester $semester Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Details for Semester $semester'),
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
  final InputDecoration? decoration;

  const InputField({
    required this.labelText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.autoFocus = false,
    this.onChanged,
    this.onSubmitted,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black, // Border color
            width: 2.0, // Border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue, // Focused border color
            width: 2.0, // Focused border width
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red, // Error border color
            width: 2.0, // Error border width
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red, // Focused error border color
            width: 2.0, // Focused error border width
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle style;

  const FormButton({
    required this.text,
    required this.onPressed,
    this.style = const ButtonStyle(),
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        primary: Colors.blue, // Button background color
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Raleway',
        ),
      ).merge(style), // Merge with provided style
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
    );
  }
}

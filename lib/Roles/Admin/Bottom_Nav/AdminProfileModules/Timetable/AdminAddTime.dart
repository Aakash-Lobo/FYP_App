import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminAddTime extends StatefulWidget {
  final String username;

  AdminAddTime({required this.username});

  @override
  _AdminAddTimeState createState() => _AdminAddTimeState();
}

class _AdminAddTimeState extends State<AdminAddTime> {
  TextEditingController courseCodeController = TextEditingController();
  TextEditingController semesterController = TextEditingController();
  TextEditingController timingFromController = TextEditingController();
  TextEditingController timingToController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController subjectCodeController = TextEditingController();
  TextEditingController roomNoController = TextEditingController();

  Future<void> addTimetableEntry() async {
    String courseCode = courseCodeController.text;
    String semester = semesterController.text;
    String timingFrom = timingFromController.text;
    String timingTo = timingToController.text;
    String day = dayController.text;
    String subjectCode = subjectCodeController.text;
    String roomNo = roomNoController.text;

    final response = await http.post(
      Uri.parse('http://localhost/fyp/app/admin/profile/timetable/addtime.php'),
      body: {
        'course_code': courseCode,
        'semester': semester,
        'timing_from': timingFrom,
        'timing_to': timingTo,
        'day': day,
        'subject_code': subjectCode,
        'room_no': roomNo,
      },
    );

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        // Handle success case
        print('Your Data has been submitted');
      } else {
        // Handle failure case
        print('Your Data has not been submitted');
      }
    } else {
      // Handle HTTP error
      print('Failed to add timetable entry');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Timetable Entry',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
          ), // Bold text
          textAlign: TextAlign.center, // Centered text
        ),
        centerTitle: true, // Center app bar title
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              labelText: 'Course Code',
              controller: courseCodeController,
            ),
            SizedBox(height: 20),
            InputField(
              labelText: 'Semester',
              controller: semesterController,
            ),
            SizedBox(height: 20),
            InputField(
              labelText: 'Timing From',
              controller: timingFromController,
            ),
            SizedBox(height: 20),
            InputField(
              labelText: 'Timing To',
              controller: timingToController,
            ),
            SizedBox(height: 20),
            InputField(
              labelText: 'Day',
              controller: dayController,
            ),
            SizedBox(height: 20),
            InputField(
              labelText: 'Subject Code',
              controller: subjectCodeController,
            ),
            SizedBox(height: 20),
            InputField(
              labelText: 'Room No',
              controller: roomNoController,
            ),
            SizedBox(height: 20),
            FormButton(
              text: 'Add Timetable Entry',
              onPressed: addTimetableEntry,
            ),
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? errorText;

  const InputField({
    required this.labelText,
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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

  const FormButton({
    required this.text,
    required this.onPressed,
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
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
    );
  }
}

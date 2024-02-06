import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditStudentPage extends StatefulWidget {
  final int studentId;
  final String regNo;
  final String firstName;
  final String middleName;
  final String lastName;
  final String roomNo;
  final String seater;
  final String stayingFrom;
  final String contactNo;

  EditStudentPage({
    required this.studentId,
    required this.regNo,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.roomNo,
    required this.seater,
    required this.stayingFrom,
    required this.contactNo,
  });

  @override
  _EditStudentPageState createState() => _EditStudentPageState();
}

class _EditStudentPageState extends State<EditStudentPage> {
  late TextEditingController regNoController;
  late TextEditingController firstNameController;
  late TextEditingController middleNameController;
  late TextEditingController lastNameController;
  late TextEditingController roomNoController;
  late TextEditingController seaterController;
  late TextEditingController stayingFromController;
  late TextEditingController contactNoController;

  @override
  void initState() {
    super.initState();
    regNoController = TextEditingController(text: widget.regNo);
    firstNameController = TextEditingController(text: widget.firstName);
    middleNameController = TextEditingController(text: widget.middleName);
    lastNameController = TextEditingController(text: widget.lastName);
    roomNoController = TextEditingController(text: widget.roomNo);
    seaterController = TextEditingController(text: widget.seater);
    stayingFromController = TextEditingController(text: widget.stayingFrom);
    contactNoController = TextEditingController(text: widget.contactNo);
  }

  Future<void> updateStudentDetails() async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/hostel/editstudent.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'studentId': widget.studentId,
          'regNo': regNoController.text,
          'firstName': firstNameController.text,
          'middleName': middleNameController.text,
          'lastName': lastNameController.text,
          'roomNo': roomNoController.text,
          'seater': seaterController.text,
          'stayingFrom': stayingFromController.text,
          'contactNo': contactNoController.text,
        }),
      );

      if (response.statusCode == 200) {
        // Successful update
        print('Student details updated successfully');
        Navigator.pop(context); // Close the edit page after update
      } else {
        // Handle error cases
        print(
            'Failed to update student details. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error updating student details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: regNoController,
              decoration: InputDecoration(labelText: 'Registration Number'),
            ),
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: middleNameController,
              decoration: InputDecoration(labelText: 'Middle Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: roomNoController,
              decoration: InputDecoration(labelText: 'Room Number'),
            ),
            TextField(
              controller: seaterController,
              decoration: InputDecoration(labelText: 'Seater'),
            ),
            TextField(
              controller: stayingFromController,
              decoration: InputDecoration(labelText: 'Staying From'),
            ),
            TextField(
              controller: contactNoController,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Call the method to update student details
                updateStudentDetails();
              },
              child: Text('Update Student'),
            ),
          ],
        ),
      ),
    );
  }
}

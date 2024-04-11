import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentFeePage extends StatefulWidget {
  final String username;

  StudentFeePage({required this.username});

  @override
  _StudentFeePageState createState() => _StudentFeePageState();
}

class _StudentFeePageState extends State<StudentFeePage> {
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  Future<void> _submitForm() async {
    final String rollNo = _rollNoController.text;
    final String amount = _amountController.text;
    final String status = 'Paid'; // Hardcoded status as 'Paid'

    try {
      final response = await http.post(
        Uri.parse('http://localhost/fyp/app/admin/profile/student/addfee.php'),
        body: {
          'roll_no': rollNo,
          'amount': amount,
          'status': status,
        },
      );
      if (response.statusCode == 200) {
        // Handle success response
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Fee',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway', // Apply Raleway font to app bar title
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            TextField(
              controller: _rollNoController,
              decoration: InputDecoration(
                labelText: 'Enter Roll No',
                hintText: 'Add Number',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Enter Amount for Fee',
                hintText: 'Add Fee',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitForm,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway', // Apply Raleway font to button text
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.blue, // Set button background color
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

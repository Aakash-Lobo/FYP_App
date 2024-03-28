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
        title: Text('Student Fee'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Student Fee Page',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _rollNoController,
              decoration: InputDecoration(labelText: 'Enter Roll No'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Enter Amount for Fee'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

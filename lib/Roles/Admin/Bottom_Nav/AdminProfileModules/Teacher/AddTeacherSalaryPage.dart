import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTeacherSalaryPage extends StatefulWidget {
  final String username;

  AddTeacherSalaryPage({required this.username});

  @override
  _AddTeacherSalaryPageState createState() => _AddTeacherSalaryPageState();
}

class _AddTeacherSalaryPageState extends State<AddTeacherSalaryPage> {
  final TextEditingController _teacherIdController = TextEditingController();

  Future<void> _submitForm() async {
    final String teacherId = _teacherIdController.text;

    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost/fyp/app/admin/profile/teacher/addsalary.php'),
        body: {
          'teacher_id': teacherId,
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success']) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Success'),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(responseData['message']),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
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
        title: Text('Add Salary'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add Salary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _teacherIdController,
              decoration: InputDecoration(labelText: 'Enter Teacher ID'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Save Data'),
            ),
            SizedBox(height: 20.0),
            Container(
              height: MediaQuery.of(context).size.height *
                  0.5, // Set a height for the view
              child: ViewSalaryPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewSalaryPage extends StatefulWidget {
  @override
  _ViewSalaryPageState createState() => _ViewSalaryPageState();
}

class _ViewSalaryPageState extends State<ViewSalaryPage> {
  List<Map<String, dynamic>> _salaryData = [];

  Future<void> _fetchSalaryData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/admin/profile/teacher/viewsalary.php'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _salaryData = responseData.cast<Map<String, dynamic>>();
        });
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
  void initState() {
    super.initState();
    _fetchSalaryData();
  }

  @override
  Widget build(BuildContext context) {
    return _salaryData.isNotEmpty
        ? ListView.builder(
            itemCount: _salaryData.length,
            itemBuilder: (context, index) {
              final salary = _salaryData[index];
              return ListTile(
                title: Text('Salary ID: ${salary['salary_id']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Teacher ID: ${salary['teacher_id']}'),
                    Text(
                        'Name: ${salary['first_name']} ${salary['middle_name']} ${salary['last_name']}'),
                    Text('Basic Salary: ${salary['basic_salary']}'),
                    Text('Medical Allowance: ${salary['medical_allowance']}'),
                    Text('HR Allowance: ${salary['hr_allowance']}'),
                    Text('Scale: ${salary['scale']}'),
                    Text('Paid Date: ${salary['paid_date']}'),
                    Text('Total Amount: ${salary['total_amount']}'),
                  ],
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

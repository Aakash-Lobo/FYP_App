import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StaffSalaryPage extends StatefulWidget {
  final String username;

  StaffSalaryPage({required this.username});

  @override
  _StaffSalaryPageState createState() => _StaffSalaryPageState();
}

class _StaffSalaryPageState extends State<StaffSalaryPage> {
  List<Map<String, dynamic>> salaryDetails = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://localhost/fyp/app/staff/Bottom/salary/viewsalary.php');
    try {
      final response = await http.post(url, body: {
        'teacher_email': widget.username,
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as List<dynamic>;
        if (responseData.isNotEmpty) {
          setState(() {
            salaryDetails = responseData.first as List<Map<String, dynamic>>;
          });
        }
      } else {
        throw Exception('Failed to load teacher profiles');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Salary Details'),
      ),
      body: salaryDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: salaryDetails.length,
              itemBuilder: (context, index) {
                final salary = salaryDetails[index];
                return ListTile(
                  title: Text('Salary ID: ${salary['salary_id']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Basic Salary: ${salary['basic_salary']}'),
                      Text('Medical Allowance: ${salary['medical_allowance']}'),
                      Text('HR Allowance: ${salary['hr_allowance']}'),
                      Text('Pay Scale: ${salary['scale']}'),
                      Text('Paid Date: ${salary['paid_date']}'),
                      Text('Total Amount: ${salary['total_amount']}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

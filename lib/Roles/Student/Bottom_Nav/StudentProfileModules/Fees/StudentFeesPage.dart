import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentFeesPage extends StatefulWidget {
  final String username;

  StudentFeesPage({required this.username});

  @override
  _StudentFeesPageState createState() => _StudentFeesPageState();
}

class _StudentFeesPageState extends State<StudentFeesPage> {
  List<Map<String, dynamic>> feeDetails = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://localhost/fyp/app/student/Bottom/fees/viewfees.php?username=${widget.username}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as List<dynamic>;
        setState(() {
          feeDetails = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fees Page'),
      ),
      body: Center(
        child: feeDetails.isEmpty
            ? CircularProgressIndicator() // Placeholder for loading indicator
            : ListView.builder(
                itemCount: feeDetails.length,
                itemBuilder: (context, index) {
                  final feeDetail = feeDetails[index];
                  return ListTile(
                    title: Text('Voucher No.: ${feeDetail['fee_voucher']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Roll No.: ${feeDetail['roll_no']}'),
                        Text(
                            'Student Name: ${feeDetail['first_name']} ${feeDetail['middle_name']} ${feeDetail['last_name']}'),
                        Text('Program: ${feeDetail['course_code']}'),
                        Text('Amount (Rs.): ${feeDetail['amount']}'),
                        Text('Posting Date: ${feeDetail['posting_date']}'),
                        Text('Status: ${feeDetail['status']}'),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

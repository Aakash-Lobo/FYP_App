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
        title: Text(
          'Fees Page',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: feeDetails.isEmpty
            ? CircularProgressIndicator() // Placeholder for loading indicator
            : ListView.builder(
                itemCount: feeDetails.length,
                itemBuilder: (context, index) {
                  final feeDetail = feeDetails[index];
                  return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        'Voucher No.: ${feeDetail['fee_voucher']}',
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Roll No.: ${feeDetail['roll_no']}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Student Name: ${feeDetail['first_name']} ${feeDetail['middle_name']} ${feeDetail['last_name']}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Program: ${feeDetail['course_code']}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Amount (Rs.): ${feeDetail['amount']}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Posting Date: ${feeDetail['posting_date']}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                          Text(
                            'Status: ${feeDetail['status']}',
                            style: TextStyle(fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

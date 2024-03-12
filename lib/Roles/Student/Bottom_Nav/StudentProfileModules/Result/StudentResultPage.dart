import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentResultPage extends StatefulWidget {
  final String username;

  StudentResultPage({required this.username});

  @override
  _StudentResultPageState createState() => _StudentResultPageState();
}

class _StudentResultPageState extends State<StudentResultPage> {
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    // Modify the URL according to your backend API endpoint
    final url = Uri.parse(
        'http://localhost/fyp/app/student/Bottom/result/viewresult.php');

    // Modify the headers according to your backend requirements
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({'roll_no': widget.username}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          results = List<Map<String, dynamic>>.from(responseData['results']);
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
        title: Text('Result Page'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              title: Text(result['courseCode'] + '-' + result['semester']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Course Code: ${result['courseCode']}'),
                  Text('Subject Code: ${result['subjectCode']}'),
                  Text('Credit Hours: ${result['creditHours']}'),
                  Text('Total Marks: ${result['totalMarks']}'),
                  Text('Obtain Marks: ${result['obtainMarks']}'),
                  Text('Grade: ${result['grade']}'),
                  Text('CGPA: ${result['cgpa']}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

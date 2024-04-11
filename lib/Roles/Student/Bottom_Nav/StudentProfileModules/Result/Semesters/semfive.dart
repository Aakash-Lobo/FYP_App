import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SemesterFiveResult extends StatefulWidget {
  final String username;

  SemesterFiveResult({required this.username});

  @override
  _SemesterTwoResultState createState() => _SemesterTwoResultState();
}

class _SemesterTwoResultState extends State<SemesterFiveResult> {
  List<Map<String, dynamic>> resultDetails = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://localhost/fyp/app/student/Bottom/result/semfive.php?username=${widget.username}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as List<dynamic>;
        setState(() {
          resultDetails = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        throw Exception('Failed to load result details');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester Two Result'),
      ),
      body: resultDetails.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: resultDetails.length,
              itemBuilder: (context, index) {
                final result = resultDetails[index];
                return ListTile(
                  title: Text('Term: ${result['term']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Course: ${result['course']}'),
                      Text('Subject: ${result['subject']}'),
                      Text('Credit Hours: ${result['credit_hours']}'),
                      Text('Total Marks: ${result['total_marks']}'),
                      Text('Obtain Marks: ${result['obtain_marks']}'),
                      Text('Grade: ${result['grade']}'),
                      Text('CGPA: ${result['cgpa']}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

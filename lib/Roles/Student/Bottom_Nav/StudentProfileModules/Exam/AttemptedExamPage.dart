import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ExamResultPage.dart';

class AttemptedExamPage extends StatefulWidget {
  final String username;

  AttemptedExamPage({required this.username});

  @override
  _AttemptedExamPageState createState() => _AttemptedExamPageState();
}

class _AttemptedExamPageState extends State<AttemptedExamPage> {
  Future<List<Map<String, dynamic>>> fetchAttemptedExams() async {
    final response = await http.get(
      Uri.parse(
          'http://localhost/fyp/app/student/Bottom/exam/get_attempted_exams.php?roll_no=${widget.username}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attempted Exams'),
      ),
      body: FutureBuilder(
        future: fetchAttemptedExams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final exam = snapshot.data![index];
                return ListTile(
                  title: Text(exam['exam_title']),
                  subtitle: Text(exam['exam_description']),
                  trailing: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExamResultPage(examData: exam),
                        ),
                      );
                    },
                    child: Text('View Result'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

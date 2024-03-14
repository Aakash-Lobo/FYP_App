import 'package:flutter/material.dart';

class ExamResultPage extends StatelessWidget {
  final Map<String, dynamic> examData;

  ExamResultPage({required this.examData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Exam Title: ${examData['exam_title']}'),
            Text('Exam Description: ${examData['exam_description']}'),
            // Display more result details as needed
          ],
        ),
      ),
    );
  }
}

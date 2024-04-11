import 'package:flutter/material.dart';

class SemesterOneFeedBack extends StatefulWidget {
  final String username;

  SemesterOneFeedBack({required this.username});

  @override
  _SemesterOneFeedBackState createState() => _SemesterOneFeedBackState();
}

class _SemesterOneFeedBackState extends State<SemesterOneFeedBack> {
  List<String> _questions = [
    'Question 1',
    'Question 2',
    'Question 3',
    'Question 4',
    'Question 5',
    'Question 6',
    'Question 7',
    'Question 8',
    'Question 9',
    'Question 10',
    'Question 11',
    'Question 12',
    'Question 13',
    'Question 14',
    'Question 15',
    'Question 16',
    'Question 17',
    'Question 18',
    'Question 19',
    'Question 20',
  ];

  Map<String, String> _selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester 1 Feedback'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_questions[index]),
                  trailing: Column(
                    children: [
                      Radio(
                        value: 'A',
                        groupValue: _selectedAnswers[_questions[index]],
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswers[_questions[index]] =
                                value.toString();
                          });
                        },
                      ),
                      Radio(
                        value: 'B',
                        groupValue: _selectedAnswers[_questions[index]],
                        onChanged: (value) {
                          setState(() {
                            _selectedAnswers[_questions[index]] =
                                value.toString();
                          });
                        },
                      ),
                      // Add more options if needed
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitFeedback();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitFeedback() {
    _selectedAnswers.forEach((question, answer) {
      print('$question: $answer');
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Feedback submitted successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    setState(() {
      _selectedAnswers.clear();
    });
  }
}

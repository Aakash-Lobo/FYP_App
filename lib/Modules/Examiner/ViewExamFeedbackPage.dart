import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewExamFeedbackPage extends StatefulWidget {
  final String username;

  ViewExamFeedbackPage({required this.username});

  @override
  _ViewExamFeedbackPageState createState() => _ViewExamFeedbackPageState();
}

class _ViewExamFeedbackPageState extends State<ViewExamFeedbackPage> {
  List<Map<String, dynamic>> feedbackData = [];

  @override
  void initState() {
    super.initState();
    // Fetch feedback data
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/exam/viewfeedback.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          feedbackData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Feedback',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: feedbackData.length,
              itemBuilder: (BuildContext context, int index) {
                var feedback = feedbackData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      feedback['fb_exmne_as'] ?? 'N/A',
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Feedbacks: ${feedback['fb_feedbacks'] ?? 'N/A'}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Date: ${feedback['fb_date'] ?? 'N/A'}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

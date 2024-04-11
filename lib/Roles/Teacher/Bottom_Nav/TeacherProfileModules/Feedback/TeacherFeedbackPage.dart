import 'package:flutter/material.dart';

class TeacherFeedbackPage extends StatelessWidget {
  final String username;

  TeacherFeedbackPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counselling Page',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3, // Assuming 3 sessions/teachers
        itemBuilder: (context, index) {
          // Generate dummy data for demonstration
          List<TeacherSessionData> dummyData = generateDummyData();

          return Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Session ${index + 1} Feedback',
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ListTile(
                    title: Text(
                      'Overall Rating: ${dummyData[index].overallRating}',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Feedback: ${dummyData[index].totalFeedback}',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          'Positive Feedback: ${dummyData[index].positiveFeedback}',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          'Negative Feedback: ${dummyData[index].negativeFeedback}',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<TeacherSessionData> generateDummyData() {
    // Generate dummy session feedback data
    return [
      TeacherSessionData(
        overallRating: 'Good',
        totalFeedback: 20,
        positiveFeedback: 15,
        negativeFeedback: 5,
      ),
      TeacherSessionData(
        overallRating: 'Excellent',
        totalFeedback: 25,
        positiveFeedback: 22,
        negativeFeedback: 3,
      ),
      // Add more sessions if needed
    ];
  }
}

class TeacherSessionData {
  final String overallRating;
  final int totalFeedback;
  final int positiveFeedback;
  final int negativeFeedback;

  TeacherSessionData({
    required this.overallRating,
    required this.totalFeedback,
    required this.positiveFeedback,
    required this.negativeFeedback,
  });
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewRankingPage extends StatefulWidget {
  final String username;

  ViewRankingPage({required this.username});

  @override
  _ViewRankingPageState createState() => _ViewRankingPageState();
}

class _ViewRankingPageState extends State<ViewRankingPage> {
  List<Map<String, dynamic>> rankingData = [];

  @override
  void initState() {
    super.initState();
    // Fetch ranking data
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/exam/viewranking.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          rankingData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _navigateToDetailedView(
      String? examineeName, String? scoreOver, String? percentage) {
    examineeName ??= 'N/A';
    scoreOver ??= 'N/A';
    percentage ??= 'N/A';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Detailed Ranking View'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Examinee: $examineeName'),
                Text('Score / Over: $scoreOver'),
                Text('Percentage: $percentage'),
                // Add more details as needed
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ranking',
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
              itemCount: rankingData.length,
              itemBuilder: (BuildContext context, int index) {
                var ranking = rankingData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      ranking['exmne_fullname'] ?? 'N/A',
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Score / Over: ${ranking['score'] ?? 'N/A'} / ${ranking['over'] ?? 'N/A'}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Percentage: ${ranking['percentage'] ?? 'N/A'}%',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _navigateToDetailedView(
                          ranking['exmne_fullname'],
                          '${ranking['score']} / ${ranking['over']}',
                          '${ranking['percentage']}',
                        );
                      },
                      child:
                          Text('View', style: TextStyle(fontFamily: 'Raleway')),
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

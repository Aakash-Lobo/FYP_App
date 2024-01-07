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
        title: Text('Ranking'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'View Ranking',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            DataTable(
              columns: [
                DataColumn(label: Text('Examinee')),
                DataColumn(label: Text('Score / Over')),
                DataColumn(label: Text('Percentage')),
                DataColumn(label: Text('Action')),
              ],
              rows: rankingData.map((ranking) {
                return DataRow(
                  cells: [
                    DataCell(Text(ranking['exmne_fullname'] ?? 'N/A')),
                    DataCell(Text(
                        '${ranking['score'] ?? 'N/A'} / ${ranking['over'] ?? 'N/A'}')),
                    DataCell(Text('${ranking['percentage'] ?? 'N/A'}%')),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          _navigateToDetailedView(
                            ranking['exmne_fullname'],
                            '${ranking['score']} / ${ranking['over']}',
                            '${ranking['percentage']}',
                          );
                        },
                        child: Text('View'),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Admin/Bottom_Nav/AdminProfileModules/Timetable/AdminAddTime.dart';
import 'package:http/http.dart' as http;

class AdminTimeTable extends StatefulWidget {
  final String username;

  AdminTimeTable({required this.username});

  @override
  _AdminTimeTableState createState() => _AdminTimeTableState();
}

class _AdminTimeTableState extends State<AdminTimeTable> {
  List<dynamic> timetableData = [];

  @override
  void initState() {
    super.initState();
    fetchTimetable();
  }

  Future<void> fetchTimetable() async {
    final response = await http.get(Uri.parse(
        'http://localhost/fyp/app/admin/profile/timetable/viewtime.php'));

    if (response.statusCode == 200) {
      setState(() {
        timetableData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load timetable data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Timetable',
          style: TextStyle(fontWeight: FontWeight.bold), // Bold text
          textAlign: TextAlign.center, // Centered text
        ),
        centerTitle: true, // Center app bar title
      ),
      body: timetableData.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: timetableData.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                      '${timetableData[index]['course_code']} ${timetableData[index]['semester']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '${timetableData[index]['timing_from']} - ${timetableData[index]['timing_to']}'),
                      Text('${timetableData[index]['day_name']}'),
                      Text('${timetableData[index]['subject_code']}'),
                      Text('${timetableData[index]['room_no']}'),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AdminAddTime(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

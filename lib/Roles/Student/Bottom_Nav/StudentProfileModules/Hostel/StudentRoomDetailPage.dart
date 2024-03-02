import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentRoomDetailPage extends StatefulWidget {
  final String username;

  StudentRoomDetailPage({required this.username});

  @override
  _StudentRoomDetailPageState createState() => _StudentRoomDetailPageState();
}

class _StudentRoomDetailPageState extends State<StudentRoomDetailPage> {
  List<Map<String, dynamic>> roomData = [];

  @override
  void initState() {
    super.initState();
    fetchRoomData();
  }

  Future<void> fetchRoomData() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://localhost/fyp/app/student/Bottom/hostel/viewmyroom.php?username=${widget.username}"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          roomData = List<Map<String, dynamic>>.from(data);
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
        title: Text('Room Detail Page'),
      ),
      body: Center(
        child: roomData.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: roomData.length,
                itemBuilder: (context, index) {
                  var room = roomData[index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Room Number: ${room['room_number']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Seater: ${room['seater']}'),
                              Text('Rent: ${room['rent']}'),
                              Text('Facilities: ${room['facilities']}'),
                              // Add more room details here as needed
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Additional Details:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Room Type: ${room['room_type']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Availability: ${room['availability']}'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Location: ${room['location']}'),
                        ),
                        // Add more room details here as needed
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

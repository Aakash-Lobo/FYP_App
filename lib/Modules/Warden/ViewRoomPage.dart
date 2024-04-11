import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Warden/AddRoomPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EditRoomPage.dart';

class ViewRoomPage extends StatefulWidget {
  final String username;

  ViewRoomPage({required this.username});

  @override
  _ViewRoomPageState createState() => _ViewRoomPageState();
}

class _ViewRoomPageState extends State<ViewRoomPage> {
  List<Map<String, dynamic>> roomsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/hostel/viewroom.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          roomsData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deleteRoom(int roomId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost/fyp/app/modules/hostel/deleteroom.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'roomId': roomId.toString()}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Room with ID $roomId deleted successfully');
      } else if (response.statusCode == 400) {
        // Bad Request
        print('Missing roomId parameter');
      } else if (response.statusCode == 500) {
        // Internal Server Error
        print('Failed to delete room. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        // Handle other status codes as needed
        print('Unexpected status code: ${response.statusCode}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting room: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Rooms',
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
              itemCount: roomsData.length,
              itemBuilder: (BuildContext context, int index) {
                var room = roomsData[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      room['room_no'].toString(),
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Seater: ${room['seater']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Fees Per Month: \$${room['fees']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // Show edit page for the room
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditRoomPage(
                                  roomId: int.parse(room['id'].toString()),
                                  roomNo: room['room_no'].toString(),
                                  seater: room['seater'].toString(),
                                  fees: room['fees'].toString(),
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            // Show confirmation dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Room'),
                                  content: Text(
                                      'Are you sure you want to delete this room?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Perform the delete
                                        deleteRoom(
                                            int.parse(room['id'].toString()));
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRoomPage(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

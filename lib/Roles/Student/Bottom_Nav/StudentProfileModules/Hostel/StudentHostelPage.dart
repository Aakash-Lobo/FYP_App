import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Hostel/StudentRoomDetailPage.dart';
import 'package:flutter_application_1/Roles/student/student_home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RoomData {
  final String roomNo;

  RoomData({required this.roomNo});

  factory RoomData.fromJson(Map<String, dynamic> json) {
    return RoomData(roomNo: json['room_no']);
  }
}

class StudentHostelPage extends StatefulWidget {
  final String username;

  StudentHostelPage({required this.username});

  @override
  _StudentHostelPageState createState() => _StudentHostelPageState();
}

class _StudentHostelPageState extends State<StudentHostelPage> {
  List<RoomData> roomsData = [];

  Future<void> fetchRoomsData() async {
    final response = await http.get(Uri.parse(
        'http://localhost/fyp/app/student/Bottom/hostel/bookroom.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        roomsData = data.map((item) => RoomData.fromJson(item)).toList();
      });
    } else {
      throw Exception('Failed to load room data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRoomsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, ${widget.username}!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Form(
              child: Column(
                children: [
                  DropdownButtonFormField(
                    items: roomsData.map((room) {
                      return DropdownMenuItem(
                        value: room.roomNo,
                        child: Text(room.roomNo),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'Room Number',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a room';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Start Date',
                    ),
                    keyboardType: TextInputType.datetime,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter start date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Seater',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter seater';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                    items: List.generate(12, (index) => index + 1).map((month) {
                      return DropdownMenuItem(
                        value: month,
                        child: Text('$month Month${month > 1 ? 's' : ''}'),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'Total Duration',
                    ),
                  ),
                  Row(
                    children: [
                      Text('Food Status'),
                      Radio(
                        value: 'required',
                        groupValue: null,
                        onChanged: (value) {},
                      ),
                      Text('Required'),
                      Radio(
                        value: 'not_required',
                        groupValue: null,
                        onChanged: (value) {},
                      ),
                      Text('Not Required'),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Total Fees Per Month',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter total fees per month';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Total Amount',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter total amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Student's Personal Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Registration Number',
                    ),
                    readOnly: true,
                    initialValue: '',
                  ),
                  // Add more fields for student's personal information similarly
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement form submission here
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: CustomSideNavigationBar(
        username: widget.username,
        onLogout: (bool isLoggingOut) {
          if (isLoggingOut) {
            // Log the user out and navigate to the login page
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
  }
}

class CustomSideNavigationBar extends StatelessWidget {
  final String username;
  final Function(bool) onLogout;

  CustomSideNavigationBar({
    required this.username,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Your Name'),
            accountEmail: Text(username),
            currentAccountPicture: CircleAvatar(
                // Add your profile picture here
                ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Room Details'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StudentRoomDetailPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              _showExitConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit Confirmation'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentHomePage(username: username),
                  ),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

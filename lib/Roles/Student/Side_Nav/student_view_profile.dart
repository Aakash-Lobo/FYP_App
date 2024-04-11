import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewStudentProfilePage extends StatefulWidget {
  final String username;

  ViewStudentProfilePage({required this.username});

  @override
  _ViewStudentProfilePageState createState() => _ViewStudentProfilePageState();
}

class _ViewStudentProfilePageState extends State<ViewStudentProfilePage> {
  Map<String, dynamic>? teacherProfile;

  @override
  void initState() {
    super.initState();
    fetchTeacherProfiles();
  }

  Future<void> fetchTeacherProfiles() async {
    final url =
        Uri.parse('http://localhost/fyp/app/student/Side_Nav/view_profile.php');
    try {
      final response = await http.post(url, body: {
        'teacher_email': widget.username,
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as List<dynamic>;
        if (responseData.isNotEmpty) {
          setState(() {
            teacherProfile = responseData.first as Map<String, dynamic>;
          });
        }
      } else {
        throw Exception('Failed to load teacher profiles');
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Profile',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: teacherProfile != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.grey[200],
                      child: Icon(
                        Icons.person,
                        size: 120,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(
                      'First Name:',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${teacherProfile!['first_name']}',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Middle Name:',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${teacherProfile!['middle_name']}',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Last Name:',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${teacherProfile!['last_name']}',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Father\'s Name:',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${teacherProfile!['father_name']}',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Email:',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '${teacherProfile!['email']}',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                      ),
                    ),
                  ),
                  // ListTile(
                  //   title: Text(
                  //     'Phone No:',
                  //     style: TextStyle(
                  //       fontFamily: 'Raleway',
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   trailing: Text(
                  //     '${teacherProfile!['phone_no']}',
                  //     style: TextStyle(
                  //       fontFamily: 'Raleway',
                  //     ),
                  //   ),
                  // ),
                  // Add other ListTile widgets for additional user details
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminViewProfilePage extends StatefulWidget {
  final String username;

  AdminViewProfilePage({required this.username});

  @override
  _AdminViewProfilePageState createState() => _AdminViewProfilePageState();
}

class _AdminViewProfilePageState extends State<AdminViewProfilePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final url =
        'http://localhost/fyp/app/student/Side_Nav/view_profile.php'; // Replace with your PHP script URL
    final response = await http.post(Uri.parse(url), body: {
      'username': widget.username,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        userData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Profile'),
      ),
      body: userData != null
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display user data here
                  Text(
                      'Name: ${userData!['first_name']} ${userData!['middle_name']} ${userData!['last_name']}'),
                  Text('Email: ${userData!['email']}'),
                  Text('Mobile Number: ${userData!['mobile_no']}'),
                  Text('Course Code: ${userData!['course_code']}'),
                  // Add other user data fields here
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

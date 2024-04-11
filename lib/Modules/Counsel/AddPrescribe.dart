import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPrescribePage extends StatelessWidget {
  final String username;
  final String pid;
  final String ID;
  final String fname;
  final String lname;
  final String appdate;
  final String apptime;

  AddPrescribePage({
    required this.username,
    required this.pid,
    required this.ID,
    required this.fname,
    required this.lname,
    required this.appdate,
    required this.apptime,
  });

  Future<void> prescribe() async {
    // Replace 'http://your-api-endpoint' with the actual API endpoint for prescription
    var url =
        Uri.parse('http://localhost/fyp/app/modules/counsel/addprescribe.php');
    var response = await http.post(url, body: {
      'doctor': username,
      'pid': pid,
      'ID': ID,
      'fname': fname,
      'lname': lname,
      'appdate': appdate,
      'apptime': apptime,
      // Add more fields here as needed
    });

    if (response.statusCode == 200) {
      // Handle success
      print('Prescription successful');
    } else {
      // Handle error
      print('Failed to prescribe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescribe'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            prescribe();
          },
          child: Text('Prescribe'),
        ),
      ),
    );
  }
}

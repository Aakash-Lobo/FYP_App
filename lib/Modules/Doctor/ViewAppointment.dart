import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Doctor/AddPrescribe.dart';
import 'package:http/http.dart' as http;

class ViewAppointmentPage extends StatefulWidget {
  final String username;

  ViewAppointmentPage({required this.username});

  @override
  _ViewAppointmentPageState createState() => _ViewAppointmentPageState();
}

class _ViewAppointmentPageState extends State<ViewAppointmentPage> {
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    var url = Uri.parse(
        'http://localhost/fyp/app/modules/health/viewappointments.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      setState(() {
        appointments = List<Map<String, dynamic>>.from(responseData);
      });
    } else {
      print('Failed to fetch appointments');
    }
  }

  Future<void> prescribe(Map<String, dynamic> appointment) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddPrescribePage(
                username: widget.username,
                pid: appointment['pid'],
                ID: appointment['ID'],
                fname: appointment['fname'],
                lname: appointment['lname'],
                appdate: appointment['appdate'],
                apptime: appointment['apptime'],
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Appointments',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          var appointment = appointments[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            elevation: 4.0,
            child: ListTile(
              title: Text(
                'Patient: ${appointment['fname']} ${appointment['lname']}',
                style: TextStyle(fontFamily: 'Raleway'),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Gender: ${appointment['gender']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Email: ${appointment['email']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Contact: ${appointment['contact']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Date: ${appointment['appdate']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Time: ${appointment['apptime']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Status: ${appointment['status']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle action button click
                        },
                        child: Text('Action',
                            style: TextStyle(fontFamily: 'Raleway')),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPrescribePage(
                                username: widget.username,
                                pid: appointment['pid'],
                                ID: appointment['ID'],
                                fname: appointment['fname'],
                                lname: appointment['lname'],
                                appdate: appointment['appdate'],
                                apptime: appointment['apptime'],
                              ),
                            ),
                          );
                        },
                        child: Text('Prescribe',
                            style: TextStyle(fontFamily: 'Raleway')),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

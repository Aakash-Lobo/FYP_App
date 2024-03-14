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
        title: Text('View Appointments'),
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          var appointment = appointments[index];
          return ListTile(
            title: Text(
                'Patient: ${appointment['fname']} ${appointment['lname']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gender: ${appointment['gender']}'),
                Text('Email: ${appointment['email']}'),
                Text('Contact: ${appointment['contact']}'),
                Text('Date: ${appointment['appdate']}'),
                Text('Time: ${appointment['apptime']}'),
                Text('Status: ${appointment['status']}'),
                ElevatedButton(
                  onPressed: () {
                    // Handle action button click
                  },
                  child: Text('Action'),
                ),
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
                  child: Text('Prescribe'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

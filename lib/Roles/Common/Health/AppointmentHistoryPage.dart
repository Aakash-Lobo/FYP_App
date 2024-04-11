import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppointmentHistoryPage extends StatefulWidget {
  final String username;

  AppointmentHistoryPage({required this.username});

  @override
  _AppointmentHistoryPageState createState() => _AppointmentHistoryPageState();
}

class _AppointmentHistoryPageState extends State<AppointmentHistoryPage> {
  List<Map<String, dynamic>> appointments = [];

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/common/health/viewhistory.php?username=${widget.username}'),
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        setState(() {
          appointments = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Failed to fetch appointment history');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment History',
            style: TextStyle(fontFamily: 'Raleway')),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          var appointment = appointments[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                'Doctor: ${appointment['doctor']}',
                style: TextStyle(
                    fontFamily: 'Raleway', fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Fees: \$${appointment['docFees']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Date: ${appointment['appdate']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Time: ${appointment['apptime']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                  Text('Status: ${appointment['status']}',
                      style: TextStyle(fontFamily: 'Raleway')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

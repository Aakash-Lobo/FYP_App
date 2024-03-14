import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewPrescribePage extends StatefulWidget {
  final String username;

  ViewPrescribePage({required this.username});

  @override
  _ViewPrescribePageState createState() => _ViewPrescribePageState();
}

class _ViewPrescribePageState extends State<ViewPrescribePage> {
  List<Map<String, dynamic>> prescriptions = [];

  @override
  void initState() {
    super.initState();
    fetchPrescriptions();
  }

  Future<void> fetchPrescriptions() async {
    var url =
        Uri.parse('http://localhost/fyp/app/modules/health/viewprescribe.php');
    var response = await http.post(url, body: {'username': widget.username});

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<Map<String, dynamic>> prescriptions =
          List<Map<String, dynamic>>.from(responseData);
      setState(() {
        prescriptions = prescriptions;
      });
    } else {
      print('Failed to fetch prescriptions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Prescriptions'),
      ),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          var prescription = prescriptions[index];
          return ListTile(
            title: Text(
                'Patient: ${prescription['fname']} ${prescription['lname']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Appointment Date: ${prescription['appdate']}'),
                Text('Appointment Time: ${prescription['apptime']}'),
                Text('Disease: ${prescription['disease']}'),
                Text('Allergy: ${prescription['allergy']}'),
                Text('Prescription: ${prescription['prescription']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

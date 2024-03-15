import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrescriptionPage extends StatefulWidget {
  final String username;

  PrescriptionPage({required this.username});

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
  List<Map<String, dynamic>> prescriptions = [];

  @override
  void initState() {
    super.initState();
    fetchPrescriptions();
  }

  Future<void> fetchPrescriptions() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/common/health/viewpres.php?username=${widget.username}'),
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        setState(() {
          prescriptions = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Failed to fetch prescriptions');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prescription Page'),
      ),
      body: ListView.builder(
        itemCount: prescriptions.length,
        itemBuilder: (context, index) {
          var prescription = prescriptions[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text('Doctor: ${prescription['doctor']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Appointment Date: ${prescription['appdate']}'),
                    Text('Appointment Time: ${prescription['apptime']}'),
                    Text('Diseases: ${prescription['disease']}'),
                    Text('Allergies: ${prescription['allergy']}'),
                    Text('Prescriptions: ${prescription['prescription']}'),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Handle payment
                  },
                  child: Text('Pay Bill'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

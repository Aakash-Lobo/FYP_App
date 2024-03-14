import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppliedJob {
  final String occupationTitle;
  final String companyName;
  final String companyAddress;
  final String remarks;

  AppliedJob({
    required this.occupationTitle,
    required this.companyName,
    required this.companyAddress,
    required this.remarks,
  });
}

class AppliedJobPage extends StatefulWidget {
  final String username;

  AppliedJobPage({required this.username});

  @override
  _AppliedJobPageState createState() => _AppliedJobPageState();
}

class _AppliedJobPageState extends State<AppliedJobPage> {
  List<AppliedJob> appliedJobs = [];

  @override
  void initState() {
    super.initState();
    fetchAppliedJobs();
  }

  Future<void> fetchAppliedJobs() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/student/Bottom/placement/appliedcompany.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          appliedJobs = List<AppliedJob>.from(data.map((job) => AppliedJob(
                occupationTitle: job['OCCUPATIONTITLE'],
                companyName: job['COMPANYNAME'],
                companyAddress: job['COMPANYADDRESS'],
                remarks: job['REMARKS'],
              )));
        });
      } else {
        throw Exception('Failed to load applied jobs');
      }
    } catch (error) {
      print('Error fetching applied jobs: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Applied Page'),
      ),
      body: ListView.builder(
        itemCount: appliedJobs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(appliedJobs[index].occupationTitle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Company: ${appliedJobs[index].companyName}'),
                Text('Address: ${appliedJobs[index].companyAddress}'),
                Text('Remarks: ${appliedJobs[index].remarks}'),
              ],
            ),
            onTap: () {
              // Handle onTap action
            },
          );
        },
      ),
    );
  }
}

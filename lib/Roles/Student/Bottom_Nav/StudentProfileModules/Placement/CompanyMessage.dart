import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompanyMessage extends StatefulWidget {
  final String username;

  CompanyMessage({required this.username});

  @override
  _CompanyMessageState createState() => _CompanyMessageState();
}

class _CompanyMessageState extends State<CompanyMessage> {
  List<CompanyMessageData> companyMessages = [];

  @override
  void initState() {
    super.initState();
    fetchCompanyMessages();
  }

  Future<void> fetchCompanyMessages() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/student/Bottom/placement/viewinbox.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          companyMessages = List<CompanyMessageData>.from(
              data.map((message) => CompanyMessageData.fromJson(message)));
        });
      } else {
        throw Exception('Failed to load company messages');
      }
    } catch (error) {
      print('Error fetching company messages: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Messages'),
      ),
      body: ListView.builder(
        itemCount: companyMessages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(companyMessages[index].companyName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(companyMessages[index].remarks),
                Text(companyMessages[index].dateTimeApproved),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CompanyMessageData {
  final String companyName;
  final String remarks;
  final String dateTimeApproved;

  CompanyMessageData({
    required this.companyName,
    required this.remarks,
    required this.dateTimeApproved,
  });

  factory CompanyMessageData.fromJson(Map<String, dynamic> json) {
    return CompanyMessageData(
      companyName: json['COMPANYNAME'],
      remarks: json['REMARKS'],
      dateTimeApproved: json['DATETIMEAPPROVED'],
    );
  }
}

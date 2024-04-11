import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StaffLeaveHistory extends StatefulWidget {
  final String username;

  StaffLeaveHistory({required this.username});

  @override
  _StaffLeaveHistoryState createState() => _StaffLeaveHistoryState();
}

class _StaffLeaveHistoryState extends State<StaffLeaveHistory> {
  List<Map<String, dynamic>> leaveHistory = [];

  @override
  void initState() {
    super.initState();
    fetchLeaveHistory();
  }

  Future<void> fetchLeaveHistory() async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/fyp/app/staff/Bottom/leave/viewleavehistory.php'),
      body: {'username': widget.username},
    );

    if (response.statusCode == 200) {
      setState(() {
        leaveHistory =
            List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      // Handle error
      print('Failed to load leave history');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave History',
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
      ),
      body: leaveHistory.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: leaveHistory.length,
              itemBuilder: (context, index) {
                final leave = leaveHistory[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text('Leave Type: ${leave['LeaveType']}',
                        style: TextStyle(fontFamily: 'Raleway')),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From: ${leave['FromDate']}',
                            style: TextStyle(fontFamily: 'Raleway')),
                        Text('To: ${leave['ToDate']}',
                            style: TextStyle(fontFamily: 'Raleway')),
                        Text('Description: ${leave['Description']}',
                            style: TextStyle(fontFamily: 'Raleway')),
                        Text('Posting Date: ${leave['PostingDate']}',
                            style: TextStyle(fontFamily: 'Raleway')),
                        Text(
                            'Admin Remark: ${leave['AdminRemark'] ?? 'Pending'}',
                            style: TextStyle(fontFamily: 'Raleway')),
                        Text('Status: ${getStatusText(leave['Status'])}',
                            style: TextStyle(fontFamily: 'Raleway')),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String getStatusText(int? status) {
    switch (status) {
      case 1:
        return 'Approved';
      case 2:
        return 'Not Approved';
      default:
        return 'Pending';
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TeacherLeaveHistory extends StatefulWidget {
  final String username;

  TeacherLeaveHistory({required this.username});

  @override
  _TeacherLeaveHistoryState createState() => _TeacherLeaveHistoryState();
}

class _TeacherLeaveHistoryState extends State<TeacherLeaveHistory> {
  List<Map<String, dynamic>> leaveHistory = [];

  @override
  void initState() {
    super.initState();
    fetchLeaveHistory();
  }

  Future<void> fetchLeaveHistory() async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/fyp/app/teacher/Bottom/leave/viewleavehistory.php'),
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
        title: Text('Leave History'),
      ),
      body: leaveHistory.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: leaveHistory.length,
              itemBuilder: (context, index) {
                final leave = leaveHistory[index];
                return ListTile(
                  title: Text('Leave Type: ${leave['LeaveType']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('From: ${leave['FromDate']}'),
                      Text('To: ${leave['ToDate']}'),
                      Text('Description: ${leave['Description']}'),
                      Text('Posting Date: ${leave['PostingDate']}'),
                      Text(
                          'Admin Remark: ${leave['AdminRemark'] ?? 'Pending'}'),
                      Text('Status: ${getStatusText(leave['Status'])}'),
                    ],
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

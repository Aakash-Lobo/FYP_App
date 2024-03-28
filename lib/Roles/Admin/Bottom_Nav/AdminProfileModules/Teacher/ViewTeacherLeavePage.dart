import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewTeacherLeavePage extends StatefulWidget {
  final String username;

  ViewTeacherLeavePage({required this.username});

  @override
  _ViewTeacherLeavePageState createState() => _ViewTeacherLeavePageState();
}

class _ViewTeacherLeavePageState extends State<ViewTeacherLeavePage> {
  late List<Map<String, dynamic>> _leaveData;

  @override
  void initState() {
    super.initState();
    _fetchLeaveData();
  }

  Future<void> _fetchLeaveData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/admin/profile/teacher/viewleave.php'), // Replace with your API endpoint
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _leaveData = responseData.cast<Map<String, dynamic>>();
        });
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Details'),
      ),
      body: _leaveData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _leaveData.length,
              itemBuilder: (context, index) {
                final leave = _leaveData[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Staff ID: ${leave['EmpId']}'),
                        Text(
                            'Staff Name: ${leave['FirstName']} ${leave['LastName']}'),
                        Text('Gender: ${leave['Gender']}'),
                        Text('Staff Email: ${leave['EmailId']}'),
                        Text('Staff Contact: ${leave['Phonenumber']}'),
                        Text('Leave Type: ${leave['LeaveType']}'),
                        Text('Leave From: ${leave['FromDate']}'),
                        Text('Leave Upto: ${leave['ToDate']}'),
                        Text('Leave Applied: ${leave['PostingDate']}'),
                        Text('Status: ${_getStatusText(leave['Status'])}'),
                        Text('Leave Conditions: ${leave['Description']}'),
                        Text(
                            'Admin Remark: ${leave['AdminRemark'] ?? "Waiting for Action"}'),
                        Text(
                            'Admin Action On: ${leave['AdminRemarkDate'] ?? "NA"}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  String _getStatusText(int status) {
    switch (status) {
      case 1:
        return 'Approved';
      case 2:
        return 'Declined';
      default:
        return 'Pending';
    }
  }
}

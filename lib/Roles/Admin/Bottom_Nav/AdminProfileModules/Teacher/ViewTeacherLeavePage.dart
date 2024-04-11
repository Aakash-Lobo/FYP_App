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
  List<Map<String, dynamic>> _leaveData = [];

  @override
  void initState() {
    super.initState();
    _fetchLeaveData();
  }

  Future<void> _fetchLeaveData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/admin/profile/teacher/viewleave.php'),
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
        title: Text(
          'Leave Details',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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

class InputField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final InputDecoration? decoration;

  const InputField({
    required this.labelText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.autoFocus = false,
    this.onChanged,
    this.onSubmitted,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black, // Border color
            width: 2.0, // Border width
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.blue, // Focused border color
            width: 2.0, // Focused border width
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red, // Error border color
            width: 2.0, // Error border width
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.red, // Focused error border color
            width: 2.0, // Focused error border width
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      ),
    );
  }
}

class FormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonStyle style;

  const FormButton({
    required this.text,
    required this.onPressed,
    this.style = const ButtonStyle(),
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: screenHeight * .02),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        primary: Colors.blue, // Button background color
        textStyle: TextStyle(
          fontSize: 16,
          fontFamily: 'Raleway',
        ),
      ).merge(style), // Merge with provided style
      child: Text(
        text,
        style: TextStyle(color: Colors.white), // Set text color to white
      ),
    );
  }
}

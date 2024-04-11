import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/Roles/Common/Health/AppointmentHistoryPage.dart';
import 'package:flutter_application_1/Roles/Common/Health/PrescriptionPage.dart';

class CommonCounselPage extends StatefulWidget {
  final String username;

  CommonCounselPage({required this.username});

  @override
  _CommonCounselPageState createState() => _CommonCounselPageState();
}

class _CommonCounselPageState extends State<CommonCounselPage> {
  String _selectedDoctor = '';
  List<Map<String, dynamic>> _doctors = [];

  @override
  void initState() {
    super.initState();
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost/fyp/app/common/health/getDoctors.php'),
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _doctors = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        print('Failed to fetch doctors');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _bookAppointment() async {
    try {
      var response = await http.post(
        Uri.parse('http://localhost/fyp/app/common/health/bookappointment.php'),
        body: {
          'doctor': _selectedDoctor,
          // Add other necessary parameters
        },
      );
      if (response.statusCode == 200) {
        // Appointment booked successfully, show a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Appointment booked successfully!'),
          ),
        );
      } else {
        // Failed to book appointment, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to book appointment. Please try again.'),
          ),
        );
      }
    } catch (e) {
      // Handle error if any
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health Page',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'), // Apply Raleway font
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Specialization:',
              style: TextStyle(
                  fontSize: 16, fontFamily: 'Raleway'), // Apply Raleway font
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDoctor,
              items: _doctors.map((doctor) {
                return DropdownMenuItem<String>(
                  value: doctor['username'],
                  child: Text(doctor['spec'],
                      style: TextStyle(
                          fontFamily: 'Raleway')), // Apply Raleway font
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDoctor = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Specialization',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Doctors:',
              style: TextStyle(
                  fontSize: 16, fontFamily: 'Raleway'), // Apply Raleway font
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDoctor,
              items: _doctors.map((doctor) {
                return DropdownMenuItem<String>(
                  value: doctor['username'],
                  child: Text('${doctor['fname']} ${doctor['lname']}',
                      style: TextStyle(
                          fontFamily: 'Raleway')), // Apply Raleway font
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDoctor = value!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Select Doctor',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _bookAppointment,
                child: Text(
                  'Book Appointment',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Raleway',
                      color:
                          Colors.white), // Apply Raleway font and white color
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(
                      vertical: 15), // Set button background color
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: CustomSideNavigationBar(
        username: widget.username,
        onLogout: (bool isLoggingOut) {
          if (isLoggingOut) {
            // Log the user out and navigate to the login page
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
    );
  }
}

class CustomSideNavigationBar extends StatelessWidget {
  final String username;
  final Function(bool) onLogout;

  CustomSideNavigationBar({
    required this.username,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Your Name'),
            accountEmail: Text(username),
            currentAccountPicture: CircleAvatar(
                // Add your profile picture here
                ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Appointment History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AppointmentHistoryPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Prescription'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrescriptionPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              _showExitConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Exit Confirmation'),
          content: Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

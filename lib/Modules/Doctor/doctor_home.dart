import 'package:flutter/material.dart';
import 'package:flutter_application_1/Credentials/logout.dart';
import 'package:flutter_application_1/Modules/Doctor/ViewAppointment.dart';
import 'package:flutter_application_1/Modules/Doctor/ViewPrescribe.dart';

class DoctorHomePage extends StatefulWidget {
  final String username;

  DoctorHomePage({required this.username});

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, ${widget.username}!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Add librarian home page content here
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
            title: Text('View Appointment'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewAppointmentPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Prescribe List'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewPrescribePage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return LogoutDialog(onLogout: onLogout);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

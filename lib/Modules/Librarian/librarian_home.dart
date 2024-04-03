import 'package:flutter/material.dart';
import 'package:flutter_application_1/Credentials/logout.dart';
import 'package:flutter_application_1/Modules/Librarian/AddBooksPage.dart';
import 'package:flutter_application_1/Modules/Librarian/BorrowedBooksPage.dart';
import 'package:flutter_application_1/Modules/Librarian/LibrarianSettingsPage.dart';
import 'package:flutter_application_1/Modules/Librarian/LibrarianUsersPage.dart';
import 'package:flutter_application_1/Modules/Librarian/ReturnedBooksPage.dart';
import 'package:flutter_application_1/Modules/Librarian/ViewBooksPage.dart';
import 'package:flutter_application_1/contact.dart';

class LibrarianHomePage extends StatefulWidget {
  final String username;

  LibrarianHomePage({required this.username});

  @override
  _LibrarianHomePageState createState() => _LibrarianHomePageState();
}

class _LibrarianHomePageState extends State<LibrarianHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Librarian Home Page'),
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
          // UserAccountsDrawerHeader(
          //   accountName: Text('Your Name'),
          //   accountEmail: Text(username),
          //   currentAccountPicture: CircleAvatar(
          //       // Add your profile picture here
          //       ),
          // ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('View Books'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewBooksPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Books'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBooksPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Borrowed Books'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BorrowedBooksPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_returned_outlined),
            title: Text('Returned Books'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReturnedBooksPage(username: username),
                ),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LibrarianSettingsPage(username: username),
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

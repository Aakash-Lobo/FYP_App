import 'package:flutter/material.dart';
import 'package:flutter_application_1/Credentials/logout.dart';
import 'package:flutter_application_1/Modules/Chef/AddMenuPage.dart';
import 'package:flutter_application_1/Modules/Chef/AddOrderCategoryPage.dart';
import 'package:flutter_application_1/Modules/Chef/ViewMenuPage.dart';
import 'package:flutter_application_1/Modules/Chef/ViewOrderCategory.dart';
import 'package:flutter_application_1/Modules/Chef/ViewOrderPage.dart';

class ChefHomePage extends StatefulWidget {
  final String username;

  ChefHomePage({required this.username});

  @override
  _ChefHomePageState createState() => _ChefHomePageState();
}

class _ChefHomePageState extends State<ChefHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chef Home Page'),
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
            title: Text('View Order'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewOrderPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('View Category'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewOrderCategoryPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Category'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddOrderCategoryPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('View Menu'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewMenuPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Menu'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMenuPage(username: username),
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

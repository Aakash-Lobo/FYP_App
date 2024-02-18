import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/student_profile.dart';
import '../../chat.dart';
import '../../contact.dart';
import '../../inbox.dart';
import '../../Credentials/logout.dart';
import 'Bottom_Nav/staff_profile.dart'; // Import the LogoutDialog class

class StaffHomePage extends StatefulWidget {
  final String username;

  StaffHomePage({required this.username});

  @override
  _StaffHomePageState createState() => _StaffHomePageState();
}

class _StaffHomePageState extends State<StaffHomePage> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentPageIndex == 0
          ? AppBar(
              title: Text('Staff Home Page'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () {
                    // Navigate to the ChatPage and pass the username
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChatPage(username: widget.username),
                      ),
                    );
                  },
                ),
              ],
            )
          : null, // Hide the app bar on other pages
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome, ${widget.username}!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Add teacher home page content here
              ],
            ),
          ),
          StaffProfilePage(username: widget.username),
          InboxPage(
              username: widget.username), // Pass the username to the InboxPage
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentPageIndex,
        pageController: _pageController,
        username: widget.username,
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

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final PageController pageController;
  final String username;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.pageController,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          label: 'Inbox',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        _navigateToPage(index, context, pageController, username);
      },
    );
  }

  void _navigateToPage(int index, BuildContext context,
      PageController pageController, String username) {
    if (index >= 0 && index < 3) {
      pageController.jumpToPage(index);
    }
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
            leading: Icon(Icons.contacts),
            title: Text('Contact'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout), // Add a logout icon
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

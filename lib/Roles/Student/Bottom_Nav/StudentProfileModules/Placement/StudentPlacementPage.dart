import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Placement/AppliedJobPage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Placement/CompanyMessage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Placement/CompanyPage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Placement/JobNotiPage.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/student_profile.dart';
import 'package:flutter_application_1/Roles/Student/student_home.dart';

class StudentPlacementPage extends StatefulWidget {
  final String username;

  StudentPlacementPage({required this.username});

  @override
  _StudentPlacementPageState createState() => _StudentPlacementPageState();
}

class _StudentPlacementPageState extends State<StudentPlacementPage> {
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _currentPageIndex == 0
          ? AppBar(
              elevation: 0,
              title: Text('Placement'),
            )
          : null,
      drawer: CustomSideNavigationBar(
        username: widget.username,
        onLogout: (bool isLoggingOut) {
          if (isLoggingOut) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: <Widget>[
          PlacementList(),
          CompanyPage(username: widget.username),
          CompanyMessage(username: widget.username),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentPageIndex,
        pageController: _pageController,
        username: widget.username,
      ),
    );
  }
}

class PlacementList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Placeholder for number of items
      itemBuilder: (context, index) {
        // Your list item widget
        return ListTile(
          title: Text('List item $index'),
          onTap: () {
            // Handle item tap
          },
        );
      },
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
          label: 'Company',
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
      child: Expanded(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StudentPlacementPage(username: username),
                  ),
                );
              },
              child: UserAccountsDrawerHeader(
                accountName: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Name'),
                    Text('View Profile', style: TextStyle(fontSize: 16)),
                  ],
                ),
                accountEmail: Text(username),
                currentAccountPicture: CircleAvatar(),
              ),
            ),
            ListTile(
              leading: Icon(Icons.contacts),
              title: Text('Applied'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppliedJobPage(username: username),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Notification'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JobNotiPage(username: username),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentHomePage(username: username),
                  ),
                );
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

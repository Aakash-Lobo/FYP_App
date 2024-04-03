import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/student_profile.dart';
import '../../chat.dart';
import '../../contact.dart';
import '../../inbox.dart';
import '../../Credentials/logout.dart';
import 'Bottom_Nav/staff_profile.dart'; // Import the LogoutDialog class
import 'package:intl/intl.dart';

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
      extendBodyBehindAppBar: true,
      appBar: _currentPageIndex == 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () {
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
              child: Scaffold(
            body: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: double.infinity,
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Welcome, User',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "How's your day?",
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            EmojiContainer('assets/General/happy.png',
                                size: 60),
                            EmojiContainer('assets/General/laugh.png',
                                size: 60),
                            EmojiContainer('assets/General/suprise.png',
                                size: 60),
                            EmojiContainer('assets/General/sad.png', size: 60),
                          ],
                        ),
                      ),
                      SizedBox(height: 60),
                      SingleChildScrollView(
                        child: Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 530,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 30.0, left: 20.0, right: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Calendar',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'View',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 70.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 7,
                                        itemBuilder: (context, index) {
                                          // Logic to generate calendar dates
                                          return Container(
                                            width: 60.0,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: index ==
                                                      DateTime.now().weekday - 1
                                                  ? Colors.blue
                                                  : Colors.transparent,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (index + 1).toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat.E().format(
                                                      DateTime.now().add(
                                                          Duration(
                                                              days: index))),
                                                  // "Text",
                                                  style: TextStyle(
                                                    fontFamily: 'Raleway',
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      height: 20,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    SizedBox(height: 10.0),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Task Manager',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'View',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Task manager tiles
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          TaskTile(
                                              title: 'Task 1',
                                              description:
                                                  'Description of Task 1'),
                                          TaskTile(
                                              title: 'Task 2',
                                              description:
                                                  'Description of Task 2'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                      height: 20,
                                      indent: 10,
                                      endIndent: 10,
                                    ),
                                    SizedBox(height: 10.0),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'News and Updates',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'View',
                                            style: TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // News section tiles
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        children: [
                                          NewsTile(
                                            image:
                                                'assets/CommonBanner/library.jpeg',
                                            title: 'News Title 1',
                                            description:
                                                'Description of News 1',
                                          ),
                                          NewsTile(
                                            image:
                                                'assets/CommonBanner/library.jpeg',
                                            title: 'News Title 2',
                                            description:
                                                'Description of News 2',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
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

class TaskTile extends StatelessWidget {
  final String title;
  final String description;

  TaskTile({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  NewsTile(
      {required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        width: 80, // Adjust this width as needed
        height: 80, // Set the height equal to the width
        child: Image.asset(image, fit: BoxFit.cover),
      ),
      title: Text(title),
      subtitle: Text(description),
    );
  }
}

class EmojiContainer extends StatelessWidget {
  final String emojiAsset;
  final double size;

  EmojiContainer(this.emojiAsset, {this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Image.asset(
          emojiAsset,
          width: size * 0.8,
          height: size * 0.8,
        ),
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

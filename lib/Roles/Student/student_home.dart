import 'package:flutter/material.dart';
import 'package:flutter_application_1/Common/about.dart';
import 'package:flutter_application_1/Common/calender.dart';
import 'package:flutter_application_1/Common/complaint.dart';
import 'package:flutter_application_1/Common/expensemanager.dart';
import 'package:flutter_application_1/Common/notice.dart';
import 'package:flutter_application_1/Common/taskmanager.dart';
import 'package:flutter_application_1/Credentials/logout.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/student_profile.dart';
import 'package:flutter_application_1/Common/settings.dart';
import 'package:flutter_application_1/Roles/Student/Side_Nav/student_view_profile.dart';
import '../../Common/contact.dart';
import '../../Common/inbox.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StudentHomePage extends StatefulWidget {
  final String username;

  StudentHomePage({required this.username});

  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  int _currentPageIndex = 0;
  late Timer _timer;
  late String currentTime;
  final PageController _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Map<String, dynamic>> news = [];

  @override
  void initState() {
    super.initState();
    currentTime = _getCurrentTime();
    _timer = Timer.periodic(Duration(minutes: 1), _updateTime);
  }

  void _updateTime(Timer timer) {
    setState(() {
      currentTime = _getCurrentTime();
    });
  }

  String _getCurrentTime() {
    final DateTime now = DateTime.now();
    final String formattedTime = DateFormat.Hm().format(now);
    return formattedTime;
  }

  Future<List<Map<String, String>>> fetchNewsData() async {
    final response = await http
        .get(Uri.parse('http://localhost/fyp/app/roles/viewnotice.php'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Map<String, String>> newsList = [];

      for (var item in responseData) {
        newsList.add({
          'image': 'assets/General/notice.jpg',
          'title': item['title'].toString(),
          'description': item['message'].toString(),
        });
      }

      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: _currentPageIndex == 0
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: <Widget>[],
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
                              EmojiContainer('assets/General/sad.png',
                                  size: 60),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CalenderPage(
                                                            username: widget
                                                                .username),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'View',
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                                                        DateTime.now().weekday -
                                                            1
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TaskManagerPage(
                                                            username: widget
                                                                .username),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'View',
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
                                                description: 'Welcome to Task'),
                                            TaskTile(
                                                title: 'Task 2',
                                                description: 'Add Your Task'),
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
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NoticePage(
                                                            username: widget
                                                                .username),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                'View',
                                                style: TextStyle(
                                                  fontFamily: 'Raleway',
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // News section tiles
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: FutureBuilder(
                                            future:
                                                fetchNewsData(), // Call the function to fetch news data
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                    child: Text(
                                                        'Error: ${snapshot.error}'));
                                              } else {
                                                // Display only the first two news items
                                                final newsList = snapshot.data!
                                                    .take(2)
                                                    .toList();
                                                return Column(
                                                  children:
                                                      newsList.map((newsItem) {
                                                    return NewsTile(
                                                      image: newsItem['image']!,
                                                      title: newsItem['title']!,
                                                      description: newsItem[
                                                          'description']!,
                                                    );
                                                  }).toList(),
                                                );
                                              }
                                            },
                                          ))
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

              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [
              //     Stack(
              //       children: [
              //         InkWell(
              //           onTap: () {
              //             _scaffoldKey.currentState!.openDrawer();
              //           },
              //           child: Hero(
              //             tag: 'welcome_image',
              //             child: Image.asset(
              //               'assets/welcome.jpg',
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //         Positioned(
              //           bottom: 24,
              //           left: 24,
              //           child: Text(
              //             '$currentTime',
              //             style:
              //                 Theme.of(context).textTheme.headline4!.copyWith(
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //           ),
              //         ),
              //         Positioned(
              //           top: MediaQuery.of(context).size.height * 0.5,
              //           left: 24,
              //           child: Row(
              //             children: [
              //               const Icon(
              //                 Icons.sunny_snowing,
              //                 color: Colors.white,
              //                 size: 30,
              //               ),
              //               const SizedBox(width: 8),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ),
          ),
          StudentProfilePage(username: widget.username),
          InboxPage(username: widget.username),
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
      subtitle: Text(
        description,
        style: TextStyle(overflow: TextOverflow.ellipsis),
      ),
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
          label: 'Modules',
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewStudentProfilePage(username: username),
                ),
              );
            },
            child: UserAccountsDrawerHeader(
              accountName: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
              accountEmail: Text(username),
              currentAccountPicture: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline_rounded),
            title: Text('View Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ViewStudentProfilePage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('FAQ'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExpenseManagerPage(username: username),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutPage(username: username),
                ),
              );
            },
          ),
          Divider(),
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
            leading: Icon(Icons.help_outline_rounded),
            title: Text('Complaint'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComplaintPage(username: username),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(username: username),
                ),
              );
            },
          ),
          Divider(),
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

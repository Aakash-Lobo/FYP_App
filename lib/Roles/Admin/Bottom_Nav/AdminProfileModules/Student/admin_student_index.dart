import 'package:flutter/material.dart';
import '../../../admin_home.dart';
import '../admin_profile.dart';
import 'AddStudentPage.dart';
import 'ViewStudentsPage.dart';
import 'AssignStudentSubjectsPage.dart';
import 'StudentAttendancePage.dart';
import 'StudentFeePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminStudent extends StatefulWidget {
  final String username;

  AdminStudent({required this.username});

  @override
  _AdminStudentState createState() => _AdminStudentState();
}

class _AdminStudentState extends State<AdminStudent> {
  List<Map<String, dynamic>> statistics = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://localhost/fyp/app/dashboard/student.php'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      setState(() {
        statistics = responseData.entries
            .map((entry) => {'name': entry.key, 'value': entry.value ?? 'N/A'})
            .toList();
      });
    } else {
      print('Failed to load statistics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        color: Colors.blue,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Welcome to the Dashboard',
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
                EmojiContainer('assets/General/happy.png', size: 60),
                EmojiContainer('assets/General/laugh.png', size: 60),
                EmojiContainer('assets/General/suprise.png', size: 60),
                EmojiContainer('assets/General/sad.png', size: 60),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: (statistics.length / 2).ceil(),
                  itemBuilder: (context, index) {
                    final firstIndex = index * 2;
                    final secondIndex = firstIndex + 1;
                    return Row(
                      children: [
                        Expanded(
                          child: statisticCard(statistics[firstIndex]),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: secondIndex < statistics.length
                              ? statisticCard(statistics[secondIndex])
                              : SizedBox.shrink(),
                        ),
                      ],
                    );
                  },
                ),
              )),
        ]),
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

Widget statisticCard(Map<String, dynamic> statistic) {
  return statistic != null
      ? Card(
          color: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
            side: BorderSide(color: Colors.black, width: 1.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    statistic['name'] ?? 'N/A',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Center(
                  child: Text(
                    '${statistic['value']}' ?? 'N/A',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      : SizedBox.shrink();
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
        // ListTile(
        //   title: Text('Dashboard'),
        //   onTap: () {
        //     Navigator.pop(context); // Close the drawer
        //     // Navigator.push to AdminStudent.dart (dashboard)
        //   },
        // ),
        // ListTile(
        //   title: Text('Add Student'),
        //   onTap: () {
        //     Navigator.pop(context); // Close the drawer
        //     // Navigator.push to AddStudentPage.dart
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => AddStudentPage(username: username),
        //       ),
        //     );
        //   },
        // ),
        ListTile(
          title: Text('View Students'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            // Navigator.push to ViewStudentsPage.dart
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewStudentsPage(username: username),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Assign Subjects'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            // Navigator.push to AssignSubjectsPage.dart
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AssignSubjectsPage(username: username),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Student Attendance'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            // Navigator.push to StudentAttendancePage.dart
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentAttendancePage(username: username),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Student Fee'),
          onTap: () {
            Navigator.pop(context); // Close the drawer
            // Navigator.push to StudentFeePage.dart
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentFeePage(username: username),
              ),
            );
          },
        ),
        ListTile(
          title: Text('Exit'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminHomePage(username: username),
              ),
            );
          },
        ),
      ],
    ));
  }
}

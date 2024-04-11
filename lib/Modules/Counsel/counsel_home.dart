import 'package:flutter/material.dart';
import 'package:flutter_application_1/Credentials/logout.dart';
import 'package:flutter_application_1/Modules/Counsel/ViewAppointment.dart';
import 'package:flutter_application_1/Modules/Counsel/ViewPrescribe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CounselHomePage extends StatefulWidget {
  final String username;

  CounselHomePage({required this.username});

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<CounselHomePage> {
  List<Map<String, dynamic>> statistics = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://localhost/fyp/app/dashboard/counsel.php'));
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
          'Counselling',
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
                      fontSize: 18.0,
                      fontFamily: 'Raleway',
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
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Appointment History'),
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
            leading: Icon(Icons.edit),
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

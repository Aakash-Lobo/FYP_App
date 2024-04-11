import 'package:flutter/material.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Result/Semesters/semfive.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Result/Semesters/semfour.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Result/Semesters/semone.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Result/Semesters/semsix.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Result/Semesters/semthree.dart';
import 'package:flutter_application_1/Roles/Student/Bottom_Nav/StudentProfileModules/Result/Semesters/semtwo.dart';

class StudentResultPage extends StatelessWidget {
  final String username;

  StudentResultPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semesters'),
      ),
      body: ListView(
        children: [
          SemestersGroup(semesters: [1, 2], username: username),
          Divider(),
          SemestersGroup(semesters: [3, 4], username: username),
          Divider(),
          SemestersGroup(semesters: [5, 6], username: username),
        ],
      ),
    );
  }
}

class SemestersGroup extends StatelessWidget {
  final List<int> semesters;
  final String username;

  SemestersGroup({required this.semesters, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: semesters.map((semester) {
        return SemesterTile(
          semester: semester,
          username: username,
        );
      }).toList(),
    );
  }
}

class SemesterTile extends StatelessWidget {
  final int semester;
  final String username;

  SemesterTile({required this.semester, required this.username});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Semester $semester'),
      children: [
        ListTile(
          title: Text('View Semester $semester'),
          onTap: () {
            switch (semester) {
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SemesterOneResult(username: username),
                  ),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SemesterTwoResult(username: username),
                  ),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterThreeResult(username: username),
                  ),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterFourResult(username: username),
                  ),
                );
                break;
              case 5:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SemesterFiveResult(username: username),
                  ),
                );
                break;
              case 6:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SemesterSixResult(username: username),
                  ),
                );
                break;
            }
          },
        ),
      ],
    );
  }
}

class SemesterDetailsPage extends StatelessWidget {
  final int semester;

  SemesterDetailsPage({required this.semester});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester $semester Details'),
      ),
      body: Center(
        child: Text('Details for Semester $semester'),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Job {
  final String occupationTitle;
  final String jobDescription;
  final String qualificationWorkExperience;
  final String datePosted;

  Job({
    required this.occupationTitle,
    required this.jobDescription,
    required this.qualificationWorkExperience,
    required this.datePosted,
  });
}

class JobNotiPage extends StatefulWidget {
  final String username;

  JobNotiPage({required this.username});

  @override
  _JobNotiPageState createState() => _JobNotiPageState();
}

class _JobNotiPageState extends State<JobNotiPage> {
  List<Job> jobs = [];

  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  Future<void> fetchJobs() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://localhost/fyp/app/student/Bottom/placement/viewnoti.php'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          jobs = List<Job>.from(data.map((job) => Job(
                occupationTitle: job['OCCUPATIONTITLE'],
                jobDescription: job['JOBDESCRIPTION'],
                qualificationWorkExperience:
                    job['QUALIFICATION_WORKEXPERIENCE'],
                datePosted: job['DATEPOSTED'],
              )));
        });
      } else {
        throw Exception('Failed to load jobs');
      }
    } catch (error) {
      print('Error fetching jobs: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noti Page'),
      ),
      body: ListView.builder(
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(jobs[index].occupationTitle),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(jobs[index].jobDescription),
                Text(jobs[index].qualificationWorkExperience),
                Text(jobs[index].datePosted),
              ],
            ),
            onTap: () {
              // Handle onTap action
            },
          );
        },
      ),
    );
  }
}

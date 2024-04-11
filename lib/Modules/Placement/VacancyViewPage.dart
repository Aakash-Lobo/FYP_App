import 'package:flutter/material.dart';
import 'package:flutter_application_1/Modules/Placement/AddVacancyPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewVacancyPage extends StatefulWidget {
  final String username;

  ViewVacancyPage({required this.username});

  @override
  _ViewVacancyPageState createState() => _ViewVacancyPageState();
}

class _ViewVacancyPageState extends State<ViewVacancyPage> {
  List<Map<String, dynamic>> jobsData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://localhost/fyp/app/modules/placement/viewjob.php"),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          jobsData = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deleteJob(String jobId) async {
    try {
      final response = await http.delete(
        Uri.parse("http://localhost/fyp/app/modules/placement/deletejob.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'job_id': jobId}),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Job with ID $jobId deleted successfully');
      } else {
        // Error in deletion
        print(
            'Failed to delete job with ID $jobId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after deletion
      fetchData();
    } catch (error) {
      print('Error deleting job: $error');
    }
  }

  Future<void> updateJob(
      String jobId, Map<String, dynamic> updatedJobData) async {
    try {
      final response = await http.post(
        Uri.parse("http://localhost/fyp/app/modules/placement/updatejob.php"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'job_id': jobId, ...updatedJobData}),
      );

      if (response.statusCode == 200) {
        print('Job with ID $jobId updated successfully');
      } else {
        print(
            'Failed to update job with ID $jobId. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      // Refresh the data after updating
      fetchData();
    } catch (error) {
      print('Error updating job: $error');
    }
  }

  void _showUpdateModal(BuildContext context, Map<String, dynamic> job) {
    TextEditingController _occupationController = TextEditingController();

    _occupationController.text = job['OCCUPATIONTITLE'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Update Job',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _occupationController,
                decoration: InputDecoration(labelText: 'Occupation Title'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Update'),
                        content:
                            Text('Are you sure you want to update this job?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              updateJob(
                                job['JOBID'],
                                {'OCCUPATIONTITLE': _occupationController.text},
                              );
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Update'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Vacancies',
          style: TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: jobsData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(
                      jobsData[index]['COMPANYNAME'],
                      style: TextStyle(fontFamily: 'Raleway'),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Occupation Title: ${jobsData[index]['OCCUPATIONTITLE']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Required Employees: ${jobsData[index]['REQ_NO_EMPLOYEES']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Salaries: ${jobsData[index]['SALARIES']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Duration of Employment: ${jobsData[index]['DURATION_EMPLOYEMENT']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Qualification/Experience: ${jobsData[index]['QUALIFICATION_WORKEXPERIENCE']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Job Description: ${jobsData[index]['JOBDESCRIPTION']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Preferred Sex: ${jobsData[index]['PREFEREDSEX']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                        Text(
                          'Sector of Vacancy: ${jobsData[index]['SECTOR_VACANCY']}',
                          style: TextStyle(fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Job'),
                                  content: Text(
                                      'Are you sure you want to delete this job?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteJob(jobsData[index]['JOBID']);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Yes'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                        IconButton(
                          onPressed: () {
                            _showUpdateModal(context, jobsData[index]);
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddVacancyPage(username: widget.username),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
